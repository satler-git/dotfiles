{ lib, ... }:
{
  services.xserver = {
    enable = lib.mkDefault true;
    xkb = {
      layout = lib.mkDefault "jp";
    };

    windowManager.i3 = {
      enable = lib.mkDefault true;
    };

    displayManager.startx.enable = true;
    desktopManager.xterm.enable = false;
  };
}
