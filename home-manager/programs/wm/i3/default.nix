{ pkgs, ... }:
{
  imports = [
    ../polybar.nix
    ./config.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
  };

  home.packages = with pkgs; [
    xclip
  ];
}
