{ pkgs, ... }:
{
  imports = [
    ../waybar
    ../wofi
    ./config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home.file.".bin/vime.sh" = {
    source = ../../../../config/bin/vime.sh;
    executable = true;
  };
}
