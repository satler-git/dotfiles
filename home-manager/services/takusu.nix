{ pkgs, lib, ... }:
{
  # takusu-desktop は ~/.config/takusu/config.toml を自身で読み込む。
  # Nix から config.toml や TAKUSU_* シークレットを生成せず、
  # package に同梱されている service と同等の systemd user unit を使う。
  systemd.user.services.takusu-desktop = {
    Unit = {
      Description = "takusu resident desktop daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = lib.getExe pkgs.takusu-desktop;
      Restart = "on-failure";
      Environment = [ "RUST_LOG=info,takusu_desktop=debug" ];
      NoNewPrivileges = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      ProtectKernelLogs = true;
      ProtectClock = true;
      ProtectHostname = true;
      ProtectHome = "read-only";
      ProtectSystem = "strict";
      StateDirectory = "takusu";
      ReadWritePaths = [
        "%S/takusu"
        "%t"
      ];
      PrivateTmp = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
        "AF_UNIX"
      ];
      RestrictNamespaces = true;
      LockPersonality = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
