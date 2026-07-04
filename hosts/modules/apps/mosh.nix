{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.mosh ];

  # mosh は UDP 60000-61000 を使用する
  # Tailscale 経由でのみ到達可能にする
  networking.firewall.interfaces.tailscale0.allowedUDPPortRanges = [
    {
      from = 60000;
      to = 61000;
    }
  ];
}
