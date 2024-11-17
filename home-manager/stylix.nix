{ pkgs, config, ... }:
let
  theme = "catppuccin-frappe";
in
{
  stylix = {
    enable = true;

    image = let
        wallpaper = name: "${pkgs.nixos-artwork.wallpapers.${name}}/share/backgrounds/nixos/nix-wallpaper-${name}.png";
      in
        wallpaper "nineish";

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK JP";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    # 無効にするターゲット
    targets.alacritty.enable = false;
    targets.firefox.enable = false;
    targets.neovim.enable = false;
    targets.waybar.enable = false;
    targets.gnome.enable = false;
    targets.zellij.enable = false;
  };
}
