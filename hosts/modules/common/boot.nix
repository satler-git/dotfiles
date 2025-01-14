# { lib, pkgs, ... }:
{
  boot = {
    # kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
      };
      timeout = 3;
      efi.canTouchEfiVariables = true;
    };
  };
}
