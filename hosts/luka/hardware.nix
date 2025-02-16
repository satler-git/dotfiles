{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/hardware/nvidia.nix
    ../modules/hardware/microbit.nix
    ../modules/hardware/nvidia.nix
    ../modules/hardware/xp-pen-pentab.nix
    ../modules/hardware/printer.nix

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
  ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "HDMI-A-1,1920x1080@60.00Hz,auto,auto"
          "DP-1,1920x1080@165.00Hz,auto,auto"
        ];
      };
    }
  ];

  services.xserver = {
    displayManager.setupCommands = ''
      # ${pkgs.xlibs.xrandr}/bin/xrandr --output DP-1 --right-of HDMI-A-1
    '';

    xrandrHeads = [
      {
        output = "HDMI-A-1";

        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
          Option "PreferredRefresh" "60"
          Option "Position" "0x0"
        '';
      }
      {
        output = "DP-1";
        primary = true;

        monitorConfig = ''
          Option "PreferredMode" "1920x1080"
          Option "PreferredRefresh" "165"
          Option "Position" "1920x0"
        '';
      }
    ];

    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };
}
