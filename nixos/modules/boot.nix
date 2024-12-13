{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    initrd.verbose = false;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
      };
      timeout = 3;
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
      themePackages = with pkgs; [
        (catppuccin-plymouth.override {
          variant = "frappe";
        })
      ];
      theme = "catppuccin-frappe";
    };
  };
}
