{
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../modules/hardware/bluetooth.nix
    ../modules/hardware/printer.nix
    ../modules/hardware/xp-pen-pentab.nix

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
  ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "eDP-1, preferred, 0x0, 1"
        ];
      };
    }
    {
      programs.waybar.settings.mainBar.modules-right = lib.mkAfter [
        "battery"
      ];
    }
  ];
}
