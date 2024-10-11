{ pkgs, ... }:
{
  home.file = {
    ".local/wallpapers/paper.png".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/ea1384e183f556a94df85c7aa1dcd411f5a69646/wallpapers/nix-wallpaper-nineish.png";
      hash = "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "/home/satler/.local/wallpapers/paper.png"
      ];
      wallpaper = [
        ",/home/satler/.local/wallpapers/paper.png"
      ];
    };
  };
}
