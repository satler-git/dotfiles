{ lib, pkgs, ... }:
{
  systemd.user.services.fcitx5-daemon = {
    Unit = {
      Description = "Fcitx5 Input Method Framework";
      After = "graphical-session.target";
    };

    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "simple";
      Restart = "on-failure";
      ExecStart = "${lib.getExe pkgs.fcitx5} -d";
    };
  };
}
