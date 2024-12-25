{ pkgs, ... }:
{
  home.packages = with pkgs; [
    exiftool
  ];
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
