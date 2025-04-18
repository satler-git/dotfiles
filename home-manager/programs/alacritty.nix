{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/share/alacritty-theme/aura.toml"
      ];
      font.normal = {
        family = "Monaspace Argon";
        style = "Regular";
      };
    };
  };
}
