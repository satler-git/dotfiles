{ pkgs, lib, ... }:
{
  systemd = {
    user.services = {
      dropbox = {
        description = "Dropbox";
        wantedBy = [ "graphical-session.target" ];
        environment = {
          QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
          QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
        };
        serviceConfig = {
          ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
          ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
          KillMode = "control-group";
          Restart = "on-failure";
          PrivateTmp = true;
          ProtectSystem = "full";
          Nice = 10;
        };
      };
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
