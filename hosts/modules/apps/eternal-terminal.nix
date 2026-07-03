{ ... }:
{
  services.eternal-terminal = {
    enable = true;
    # デフォルトポート 2022
    # 認証はPAMをそのまま使用し、Tailscale 経由でのみ到達可能にする
  };

  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 2022 ];
}
