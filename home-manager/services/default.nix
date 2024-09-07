let
  dunst = import ./dunst.nix;
  gpg-agent = import ./gpg-agent.nix;
  hyprpaper = import ./hyprpaper.nix;
in
{
  imports = [
    dunst
    gpg-agent
    hyprpaper
  ];
}
