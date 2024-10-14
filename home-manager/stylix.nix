{ pkgs, config, ... }:
let
  theme = "catppuccin-frappe";
  wallpaper = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/ea1384e183f556a94df85c7aa1dcd411f5a69646/wallpapers/nix-wallpaper-nineish.png";
      hash = "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
  };
in{
  stylix.enable = true;

  stylix.image = wallpaper;

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

  # 無効にするターゲット
  stylix.targets.alacritty.enable = false;
  stylix.targets.firefox.enable = false;
  stylix.targets.neovim.enable = false;
  stylix.targets.waybar.enable = false;
}
