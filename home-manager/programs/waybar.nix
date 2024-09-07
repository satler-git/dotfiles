{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
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
      };
    };
  };
}
