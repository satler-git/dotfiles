{ pkgs, ... }:
{
  programs = {
    gpg.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    keybase.enable = true;
  };

  home.packages = with pkgs; [
    keybase-gui
  ];
}
