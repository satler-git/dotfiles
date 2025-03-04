{ config, lib, ... }:
{
  sops.secrets.tailscale = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale.path;

    useRoutingFeatures = "both";

    extraUpFlags = [
      "--ssh"
    ];
  };

  networking = {
    firewall.allowedTCPPorts = lib.mkBefore [
      22
    ];

    firewall.interfaces.tailscale0.allowedTCPPorts = [ 2222 ];

    nameservers = lib.mkBefore [
      "100.100.100.100"
    ];
  };
}
