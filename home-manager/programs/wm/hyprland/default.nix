{ pkgs, ... }:
{
  imports = [
    ../waybar
    # ../wofi
    ./config.nix
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

  programs.hyprlock = {
    enable = true;
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
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 420;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  home.file.".local/bin/vime.sh" = {
    source = ../../../../config/bin/vime.sh;
    executable = true;
  };
}
