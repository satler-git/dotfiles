{ pkgs, ... }:
{
  imports = [
    ../waybar
    ../wofi
    ./config.nix
  ];

  home.packages = with pkgs; [
    bibata-cursors

    clipse

    wl-clipboard

    grim # for screenshot in wayland
    slurp
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home.file.".local/bin/vime.sh" = {
    source = ../../../../config/bin/vime.sh;
    executable = true;
  };
}
