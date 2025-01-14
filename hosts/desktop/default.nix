{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix

    ../modules/libvirt.nix
    ../modules/common

    ../modules/home-manager.nix

    ../modules/users/satler.nix
  ];

  system.stateVersion = "24.05"; # Don't change this

  my.hostName = "satlerdev";
}
