{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix

    ../modules/libvirt.nix
  ];

  networking.hostName = "satlerdev"; # Define your hostname.
}
