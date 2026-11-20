{ pkgs, lib, ... }:
{
  boot = {
    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    plymouth = {
      enable = lib.mkDefault true;
      themePackages =
        with pkgs;
        lib.mkBefore [
          (catppuccin-plymouth.override {
            variant = "frappe";
          })
        ];
      theme = lib.mkDefault "catppuccin-frappe";
    };
  };
}
