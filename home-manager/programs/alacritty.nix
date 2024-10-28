{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/aura.toml"
      ];
      font.normal = {
        family = "monaspace Argon";
        style = "Regular";
      };
    };
  };
}
