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
  };

  services.ollama.acceleration = lib.mkDefault "cuda";
  services.xserver.videoDrivers = lib.mkBefore [ "nvidia" ];
}
