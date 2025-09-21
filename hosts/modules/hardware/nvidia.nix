{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
  ];

  hardware.nvidia-container-toolkit.enable = lib.mkDefault true;

  hardware.nvidia = {
    powerManagement.enable = lib.mkDefault false;
    powerManagement.finegrained = lib.mkDefault false;

    nvidiaSettings = lib.mkDefault true;

    open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);

    package = nvidiaPackage;
  };

  environment = {
    variables = {
      # for nvidia on Hyprland, see https://wiki.hyprland.org/Nvidia/

      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };

    systemPackages = with pkgs; [
      egl-wayland
      nvidia-vaapi-driver
    ];

    ## See: https://yalter.github.io/niri/Nvidia.html
    # https://github.com/erahhal/nixcfg/blob/3835b42ea0d6099d3bf5c82a4c675d4a35e922e7/profiles/niri.nix#L92
    etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json" =
      {
        text = builtins.toJSON {
          rules = [
            {
              pattern = {
                feature = "procname";
                matches = "niri";
              };
              profile = "Limit Free Buffer Pool On Wayland Compositors";
            }
            {
              pattern = {
                feature = "procname";
                matches = ".Hyprland-wrapped";
              };
              profile = "Limit Free Buffer Pool On Wayland Compositors";
            }
          ];
          profiles = [
            {
              name = "Limit Free Buffer Pool On Wayland Compositors";
              settings = [
                {
                  key = "GLVidHeapReuseRatio";
                  value = 0;
                }
              ];
            }
          ];
        };
      };
  };

  services.ollama.acceleration = lib.mkDefault "cuda";
  services.xserver.videoDrivers = lib.mkBefore [ "nvidia" ];
}
