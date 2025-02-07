{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix

    ../modules/common/common.nix
    ../modules/common/desktop.nix

    ../modules/home-manager.nix

    ../modules/users/satler.nix

    ../modules/boot/plymouth.nix
    # ../modules/secureboot.nix

    ./apps.nix
  ];

  system.stateVersion = "24.05"; # Don't change this

  my.hostName = "satlerdev";

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-session --asterisks --cmd ${lib.getExe config.programs.hyprland.package}";
        user = "satler";
      };
    };
  };
}
