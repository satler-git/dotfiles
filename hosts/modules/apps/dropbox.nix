{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.services.dropbox;
in
{
  options = {
    my.services.dropbox = {
      enable = mkEnableOption "enable dropbox";
      package = mkOption {
        type = types.package;
        default = pkgs.dropbox;
      };
      openFirewall = mkOption {
        type = types.bool;
        default = config.my.openFirewall;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dropbox-cli
    ];

    systemd.user.services.dropbox = {
      description = "Dropbox";
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${lib.getBin cfg.package}/bin/dropbox";
        ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
        KillMode = "control-group";
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };

    networking = lib.mkIf cfg.openFirewall {
      firewall = {
        allowedTCPPorts = [
          17500
        ];
        allowedUDPPorts = [
          17500
        ];
      };
    };
  };
}
