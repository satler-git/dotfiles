{ lib, ... }:
{
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

  };

  # DMS 内蔵のロック画面 (loginctl lock-session にも反応する) を使うので hyprlock は不要
  programs.hyprlock.enable = lib.mkForce false;

  # DMS のバッテリー表示は UPower 経由
  services.upower.enable = true;

  home-manager.sharedModules = [
    (
      { pkgs, lib, ... }:
      {
        # アイドル管理・通知も DMS に任せる
        services.swayidle.enable = lib.mkForce false;
        services.dunst.enable = lib.mkForce false;

        # dunstify は通知の送信に使うので残す
        # (pkgs.dunst をそのまま入れると D-Bus activation で dunst が起動しうるので bin だけ)
        home.packages = [
          (pkgs.runCommand "dunstify" { } ''
            mkdir -p $out/bin
            ln -s ${pkgs.dunst}/bin/dunstify $out/bin/dunstify
          '')
        ];
      }
    )
  ];
}
