{ config, ... }:
{
  sops.secrets.tailscale = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale.path;
    extraUpFlags = [
      "--operator=satler"
    ];
  };
}
