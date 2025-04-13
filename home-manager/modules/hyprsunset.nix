{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.services.hyprsunset;
in
{
  options = {
    my.services.hyprsunset = {
      enable = mkEnableOption "enable automated hyprsunset";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprsunset;
      };
      temperature = mkOption {
        type = types.int;
        default = 2500;
      };
      on_at = mkOption {
        type = types.str;
        default = "23:00";
      };
      off_at = mkOption {
        type = types.str;
        default = "6:30";
      };
    };
  };

  config =
    let
      hyprsunset = "${pkgs.hyprland}/hyprctl hyprsunset";

      on = "${hyprsunset} temperature ${builtins.toString cfg.temperature}";
      off = "${hyprsunset} identity";
    in

    lib.mkIf cfg.enable {
      home.packages = [
        cfg.package
      ];

      wayland.windowManager.hyprland.settings.exec-once = [ "hyprsunset" ];

      systemd.user.services = {
        hyprsunset-on = {
          Unit = {
            Description = "Enable hyprsunset blue‑light filter";
            After = [ "hyprland-session.target" ];
            Requires = [ "hyprland-session.target" ];
          };

          Install.WantedBy = [ "default.target" ];

          Service = {
            Type = "oneshot";
            ExecStart = on;
          };
        };

        hyprsunset-off = {
          Unit = {
            Description = "Disable hyprsunset blue‑light filter";
            After = [ "hyprland-session.target" ];
            Requires = [ "hyprland-session.target" ];
          };

          Install.WantedBy = [ "default.target" ];

          Service = {
            Type = "oneshot";
            ExecStart = off;
          };
        };
      };

      systemd.user.timers = {
        hyprsunset-on = {
          Unit = {
            Description = "Timer to enable blue‑light filter";
          };

          Install.wantedBy = [ "timers.target" ];

          Timer = {
            OnCalendar = cfg.on_at;
            Persistent = true;
          };
        };
        hyprsunset-off = {
          Unit = {
            Description = "Timer to disable blue‑light filter";
          };

          Install.wantedBy = [ "timers.target" ];

          Timer = {
            OnCalendar = cfg.off_at;
            Persistent = true;
          };
        };
      };
    };
}
