{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix

    ../modules/libvirt.nix
    ../modules/common

    ../modules/home-manager.nix

    ../modules/users/satler.nix

    ../modules/plymouth.nix
  ];

  system.stateVersion = "24.05"; # Don't change this

  my.hostName = "satlerdev";

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;
}
