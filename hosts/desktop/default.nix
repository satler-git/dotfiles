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

    ../modules/libvirt.nix
    ../modules/common

    ../modules/home-manager.nix

    ../modules/users/satler.nix

    ../modules/boot/plymouth.nix
    # ../modules/secureboot.nix

    ../modules/i3.nix
    ../modules/hyprland.nix
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

  networking = {
    firewall = {
      allowedTCPPorts = [
        17500 # Dropbox
      ];
      allowedUDPPorts = [
        17500 # Dropbox
        57120 # SuperColider
      ];
    };
  };
}
