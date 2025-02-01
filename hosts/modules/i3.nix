{ lib, ... }:
{
  services.xserver = {
    enable = lib.mkDefault true;
    videoDrivers = [ "vmware" ];
    xkb = {
      layout = lib.mkDefault "jp";
    };

    windowManager.i3 = {
      enable = lib.mkDefault true;
    };
  };
}
