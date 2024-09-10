{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/aura.toml"
      ];
      font.normal = {
        family = "monaspace Argon";
        style = "Regular";
      };
    };
  };
}
