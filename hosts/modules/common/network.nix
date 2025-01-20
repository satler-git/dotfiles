{ lib, ... }:
{
  networking = {
    networkmanager.enable = lib.mkDefault true;

    nameservers = [
      "8.8.8.8"
      "4.4.4.4"
    ];

    firewall.enable = lib.mkDefault true;
  };
}
