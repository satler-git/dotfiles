{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix

    ../modules/libvirt.nix
    ../modules/common
  ];

  my.hostName = "satlerdev";
}
