{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.mosh ];

  # mosh は UDP 60000-61000 を使用する
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 60000;
      to = 61000;
    }
  ];
}
