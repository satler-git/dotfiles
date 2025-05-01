{ pkgs, ... }:
{
  programs = {
    gpg.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 3600;
      defaultCacheTtlSsh = 3600;
      maxCacheTtl = 3600;
      maxCacheTtlSsh = 3600;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-qt;
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
