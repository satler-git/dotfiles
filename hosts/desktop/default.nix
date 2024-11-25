{
  imports = [
    ./hardware.nix
    ./hardware-configrations.nix
  ];

  networking.hostName = "satlerdev"; # Define your hostname.
}
