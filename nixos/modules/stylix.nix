{ pkgs, config, ... }:
let
  theme = "catppuccin-frappe";
in
{
  stylix = {
    homeManagerIntegration.followSystem = false;
    homeManagerIntegration.autoImport = true;

    enable = false;

    # image = pkgs.fetchurl {
    #     url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/ea1384e183f556a94df85c7aa1dcd411f5a69646/wallpapers/nix-wallpaper-nineish.png";
    #     hash = "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
    # };

    # cursor.package = pkgs.bibata-cursors;
    # cursor.name = "Bibata-Modern-Ice";
    #
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  };
}
