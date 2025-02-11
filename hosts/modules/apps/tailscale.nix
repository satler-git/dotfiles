{ config, lib, ... }:
{
  sops.secrets.tailscale = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale.path;
    extraUpFlags = [
      "--ssh"
    ];
  };

  networking.nameservers = lib.mkBefore [
    "100.100.100.100"
  ];
}
