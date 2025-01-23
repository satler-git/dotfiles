{ pkgs, ... }:
{
  programs = {
    gpg.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 600;
      maxCacheTtl = (60 * 60) * 2;
      pinentryPackage = pkgs.pinentry-qt;
    };

    keybase.enable = true;
    kbfs = {
      enable = true;

      extraFlags = [
        "-label kbfs"
      ];
    };
  };

  home.packages = with pkgs; [
    keybase-gui
  ];
}
