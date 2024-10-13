{ pkgs, ... }:
let
  config = import ./config.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = with pkgs; [
      hyprlandPlugins.hy3
    ];
    settings = config;
  };
}
