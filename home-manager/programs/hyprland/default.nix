let
  config = import ./config.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = config;
  };
}
