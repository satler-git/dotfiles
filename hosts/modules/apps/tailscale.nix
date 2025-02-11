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

  networking = {
    firewall.allowedTCPPorts = lib.mkBefore [
      22
    ];
    nameservers = lib.mkBefore [
      "100.100.100.100"
    ];
  };
}
