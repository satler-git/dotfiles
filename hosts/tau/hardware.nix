{
  inputs,
  ...
}:
{
  imports = [
    ../modules/hardware/xp-pen-pentab.nix
    ../modules/hardware/printer.nix

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
  ];
}
