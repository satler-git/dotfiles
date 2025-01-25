{
  inputs,
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
}
