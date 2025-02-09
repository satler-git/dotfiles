{ config, lib, ... }:
{
  sops.secrets.tailscale = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale.path;
    extraUpFlags = [
      "--operator=satler"
    ];
  };

  networking.nameservers = lib.mkBefore [
    "100.100.100.100"
  ];
}
