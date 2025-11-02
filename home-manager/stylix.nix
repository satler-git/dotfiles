{ pkgs, ... }:
let
  theme = "catppuccin-mocha";
in
{
  stylix = {
    enable = true;

    image =
      let
        wallpaper =
          name: "${pkgs.nixos-artwork.wallpapers.${name}}/share/backgrounds/nixos/nix-wallpaper-${name}.png";
      in
      wallpaper "nineish";

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    base16Scheme = ../config/base16/aurum.yaml;

    fonts = {
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans JP";
      };

      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans JP";
      };

      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Argon";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    # 無効にするターゲット
    targets =
      { }
      // builtins.foldl' (acc: elem: acc // elem) { } (
        builtins.map (x: { "${x}".enable = false; }) [
          "alacritty"
          "firefox"
          "gnome"
          "gnome-text-editor"
          "neovim"
          "vscode"
          "waybar"
          "wpaperd"
          "zellij"
        ]
      );
  };
}
