{
  inputs,
  ...
}:

{
  imports = [
    ../modules/hardware/nvidia.nix
    ../modules/hardware/microbit.nix
    ../modules/hardware/xp-pen-pentab.nix
    ../modules/hardware/printer.nix

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
  ];

  networking.hosts = {
    "127.0.0.1" = [
      # "x.com"
      # "app.slack.com"
      # "youtube.com"
      # "tv.dmm.com"
    ];
  };

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "HDMI-A-1,1920x1080@60.00Hz,auto,auto"
          "DP-1,1920x1080@165.00Hz,auto,auto"
        ];
      };
    }
    {
      programs.niri.settings.outputs = {
        "HDMI-A-1" = {
          position = {
            x = 0;
            y = 0;
          };
        };
        "DP-1" = {
          position = {
            x = 1920;
            y = 0;
          };
        };
      };
    }
  ];
}
