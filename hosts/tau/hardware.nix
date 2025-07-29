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

  services.logind.lidSwitch = "suspend"; # default

  services.thinkfan.enable = true;
  boot.kernelParams = [
    "thinkpad_acpi.fan_control=1"
  ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "eDP-1, preferred, 0x0, 1.25"
        ];
      };
      services.hypridle.enable = true;
    }
    {
      programs.waybar.settings.mainBar.modules-right = lib.mkBefore [
        "battery"
      ];
    }
    {
      programs.yurf = {
        task = [
          {
            name = "light: Increase by 10";
            command = "light -A 10";
          }
          {
            name = "light: Decrease by 10";
            command = "light -U 10";
          }
          {
            name = "Open Bluetooth Manager";
            command = "blueman-manager";
          }
        ];
      };
    }
  ];
}
