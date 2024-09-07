let
  dunst = import ./dunst.nix;
  hyprpaper = import ./hyprpaper.nix;
in
{
  imports = [
    dunst
    hyprpaper
  ];
}
