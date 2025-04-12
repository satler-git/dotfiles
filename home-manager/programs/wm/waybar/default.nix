{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar-style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [
          "clock"
          "custom/media"
        ];
        modules-right = [
          "wireplumber"
          "privacy"
          "tray"
        ];

        "clock" = {
          timezones = "Asia/Tokyo";
          format = "{:%H:%M}  ";
          # tooltip = true;
          # tooltip-format = "{calendar}";
          # calendar = {
          #   mode = "month";
          #   format = {
          #     months = "<span color='#ffead3'><b>{}</b></span>";
          #     days = "<span color='#ecc6d9'><b>{}</b></span>";
          #     weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          #     weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          #     today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          #   };
          # };
        };

        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };

        "hyprland/workspaces" = {
          # format = "<sub>{icon}</sub>\n{windows}";
          format = "{icon}";
          window-rewrite = {
            "title<.*youtube.*>" = "";
            "class<firefox>" = "";
            "class<firefox> title<.*github.*>" = "";
            "Alacritty vim nvim clipse" = "";
          };
        };

        "tray" = {
          icon-size = 21;
          spaceing = 23;
        };

        "privacy" = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };
        "custom/media" = {
          interval = 5;
          format = "{icon} {}";
          max-length = 30;
          tooltip = false;
          format-icons = {
            default = " ";
            spotify = " ";
          };
          escape = true;
          exec = "playerctl metadata --format '{{ title }} -- {{ artist }}'";
          on-click = "playerctl play-pause";
        };
      };
    };
  };
}
