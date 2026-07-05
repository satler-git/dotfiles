{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.services.batteryWarn;
in
{
  options.my.services.batteryWarn = {
    enable = mkEnableOption "battery low‑level notifier";

    threshold = mkOption {
      type = types.int;
      default = 15;
      description = "Capacity percentage at or below which notifications fire.";
    };

    pollIntervalSeconds = mkOption {
      type = types.int;
      default = 30;
      description = "Polling interval for the battery status.";
    };

    notifyPackage = mkOption {
      type = types.package;
      default = pkgs.libnotify;
      defaultText = lib.literalExpression "pkgs.libnotify";
      description = "Package providing notify-send.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.notifyPackage ];

    systemd.user.services.battery-warn = {
      description = "Notify on low battery (discharging, below threshold)";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
        ExecStart = toString (
          pkgs.writers.writeBash "battery-warn" ''
            set -euo pipefail

            PATH="${lib.makeBinPath [ cfg.notifyPackage pkgs.coreutils ]}:$PATH"

            state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/battery-warn"
            mkdir -p "$state_dir"
            state_file="$state_dir/last_notified"

            bat=""
            for d in /sys/class/power_supply/BAT*; do
              [ -d "$d" ] || continue
              bat="$d"
              break
            done
            if [ -z "$bat" ]; then
              echo "no battery found" >&2
              exit 0
            fi

            read_capacity() { tr -d '[:space:]' < "$bat/capacity"; }
            read_status()   { tr -d '[:space:]' < "$bat/status"; }

            threshold=${toString cfg.threshold}
            interval=${toString cfg.pollIntervalSeconds}

            while true; do
              capacity=$(read_capacity || echo "")
              status=$(read_status || echo "")

              if [ -n "$capacity" ] && [ -n "$status" ]; then
                charging=0
                case "$status" in
                  Charging|Full|Not charging) charging=1 ;;
                esac

                if [ "$charging" -eq 0 ] && [ "$capacity" -le "$threshold" ]; then
                  last_notified=""
                  [ -f "$state_file" ] && last_notified=$(tr -d '[:space:]' < "$state_file")

                  if [ -z "$last_notified" ] || [ "$capacity" -lt "$last_notified" ]; then
                    notify-send \
                      --urgency=critical \
                      --icon=battery-caution \
                      "Battery Low" "''${capacity}% remaining, not charging."
                    echo "$capacity" > "$state_file"
                  fi
                else
                  # reset state once we are charging or above threshold
                  if [ -f "$state_file" ]; then
                    rm -f "$state_file"
                  fi
                fi
              fi

              sleep "$interval"
            done
          ''
        );
      };
    };
  };
}
