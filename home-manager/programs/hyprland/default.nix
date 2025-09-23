{ pkgs, ... }:
{
  imports = [
    ../waybar.nix
    # ../wofi
    ./config.nix
    ../wayland.nix
  ];

  home.packages = with pkgs; [
    bibata-cursors

    clipse

    wl-clipboard

    grim # for screenshot in wayland
    slurp

    hyprland-qtutils
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "systemd-ac-power || loginctl lock-session"; # so we lock if we are using battery
        }
        {
          timeout = 420;
          on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
          on-resume = "systemd-ac-power || hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemd-ac-power || systemctl suspend";
        }
      ];
    };
  };

  my.services.hyprsunset = {
    enable = true;
    autoSwitch.enable = false;
  };

  home.file.".local/bin/vime.sh" = {
    source = ../../../config/bin/vime.sh;
    executable = true;
  };
}
