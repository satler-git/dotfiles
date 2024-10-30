{ pkgs, ... }:
let
  config = import ./config.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = config;
  };

  home.file.".bin/vime.sh" = {
    source = ../../../../config/bin/vime.sh;
    executable = true;
  };
}
