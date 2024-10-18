{ pkgs, ... }:
{
  programs.taskwarrior = {
    enable = false;
    package = pkgs.taskwarrior3;
  };
}
