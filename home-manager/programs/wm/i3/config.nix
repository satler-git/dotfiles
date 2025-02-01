{ config, ... }:
let
  modifier = config.xsession.windowManager.i3.config.modifier;

  terminal = "alacritty";
  fileManager = "alacritty --embed=\"zsh -c\" --command=\"yazi\"";
  launcher = "wofi --show drun";
in
{
  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    terminal = "${terminal}";

    keybindings = {
      "$mod+Return" = "exec --no-startup-id ${terminal}";
      "$mod+e" = "exec --no-startup-id \"${fileManager}\"";
      "$mod+v" = "exec --no-startup-id \"alacritty --class clipse -e clipse\"";

      "$mod+q" = "kill";

      "$mod+h" = "left";
      "$mod+j" = "down";
      "$mod+k" = "up";
      "$mod+l" = "right";

      "$mod+Shift+h" = "move left";
      "$mod+Shift+j" = "move down";
      "$mod+Shift+k" = "move up";
      "$mod+Shift+l" = "move right";

      "$mod+semicolon" = "split horizontal";

      # ワークスペース切り替え
      "$mod+1" = "workspace 1";
      "$mod+2" = "workspace 2";
      "$mod+3" = "workspace 3";
      "$mod+4" = "workspace 4";
      "$mod+5" = "workspace 5";
      "$mod+6" = "workspace 6";
      "$mod+7" = "workspace 7";
      "$mod+8" = "workspace 8";
      "$mod+9" = "workspace 9";
      "$mod+0" = "workspace 10";

      # ウィンドウをワークスペースに移動
      "$mod+Shift+1" = "move container to workspace 1";
      "$mod+Shift+2" = "move container to workspace 2";
      "$mod+Shift+3" = "move container to workspace 3";
      "$mod+Shift+4" = "move container to workspace 4";
      "$mod+Shift+5" = "move container to workspace 5";
      "$mod+Shift+6" = "move container to workspace 6";
      "$mod+Shift+7" = "move container to workspace 7";
      "$mod+Shift+8" = "move container to workspace 8";
      "$mod+Shift+9" = "move container to workspace 9";
      "$mod+Shift+0" = "move container to workspace 10";

      "XF86AudioRaiseVolume" = "exec --no-startup-id \"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+\"";
      "XF86AudioLowerVolume" = "exec --no-startup-id \"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\"";
      "XF86AudioMute" = "exec --no-startup-id \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\"";

      "XF86AudioPlay" = "exec \"playerctl play-pause\"";
      "XF86AudioPrev" = "exec \"playerctl previous\"";
      "XF86AudioNext" = "exec \"playerctl next\"";

      "$mod+Shift+w" = "move scratchpad";
      "$mod+w" = "scratchpad show";
    };

    window.commands = [
      {
        command = "floating enable";
        criteria = {
          class = "(?i)^clipse";
        };
      }
      {
        command = "floating enable, sticky enable";
        criteria = {
          class = "^firefox";
          title = "^(ピクチャーインピクチャー)";
        };
      }
      {
        command = "floating enable, sticky enable";
        criteria = {
          class = "^firefox";
          title = "^(Picture-in-Picture)";
        };
      }
    ];

    startup = [
      {
        command = "clipse -listen";
        notification = false;
      }
      {
        command = "fcitx5";
        notification = false;
      }
      {
        command = "polybar";
        notification = false;
      }
    ];
  };
}
