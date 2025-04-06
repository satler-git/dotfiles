{
  config,
  pkgs,
  lib,
  ...
}:
let
  modifier = config.xsession.windowManager.i3.config.modifier;

  terminal = "alacritty";
  fileManager = "alacritty --embed=\\\"zsh -c\\\" --command=\\\"yazi\\\"";
  launcher = "wofi --show drun";
in
{
  xsession.windowManager.i3.config = {
    modifier = "Mod1";
    terminal = "${terminal}";

    keybindings = {
      "${modifier}+Return" = "exec --no-startup-id ${terminal}";
      "${modifier}+e" = "exec --no-startup-id \"${fileManager}\"";
      "${modifier}+v" = "exec --no-startup-id \"alacritty --class clipse -e clipse\"";

      "${modifier}+q" = "kill";

      "${modifier}+h" = "left";
      "${modifier}+j" = "down";
      "${modifier}+k" = "up";
      "${modifier}+l" = "right";

      "${modifier}+Shift+h" = "move left";
      "${modifier}+Shift+j" = "move down";
      "${modifier}+Shift+k" = "move up";
      "${modifier}+Shift+l" = "move right";

      "${modifier}+semicolon" = "split horizontal";

      # ワークスペース切り替え
      "${modifier}+1" = "workspace 1";
      "${modifier}+2" = "workspace 2";
      "${modifier}+3" = "workspace 3";
      "${modifier}+4" = "workspace 4";
      "${modifier}+5" = "workspace 5";
      "${modifier}+6" = "workspace 6";
      "${modifier}+7" = "workspace 7";
      "${modifier}+8" = "workspace 8";
      "${modifier}+9" = "workspace 9";
      "${modifier}+0" = "workspace 10";

      # ウィンドウをワークスペースに移動
      "${modifier}+Shift+1" = "move container to workspace 1";
      "${modifier}+Shift+2" = "move container to workspace 2";
      "${modifier}+Shift+3" = "move container to workspace 3";
      "${modifier}+Shift+4" = "move container to workspace 4";
      "${modifier}+Shift+5" = "move container to workspace 5";
      "${modifier}+Shift+6" = "move container to workspace 6";
      "${modifier}+Shift+7" = "move container to workspace 7";
      "${modifier}+Shift+8" = "move container to workspace 8";
      "${modifier}+Shift+9" = "move container to workspace 9";
      "${modifier}+Shift+0" = "move container to workspace 10";

      "XF86AudioRaiseVolume" = "exec --no-startup-id \"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+\"";
      "XF86AudioLowerVolume" = "exec --no-startup-id \"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\"";
      "XF86AudioMute" = "exec --no-startup-id \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\"";

      "XF86AudioPlay" = "exec \"playerctl play-pause\"";
      "XF86AudioPrev" = "exec \"playerctl previous\"";
      "XF86AudioNext" = "exec \"playerctl next\"";

      "${modifier}+Shift+w" = "move scratchpad";
      "${modifier}+w" = "scratchpad show";

      "Ctrl+Shift+c" = "${lib.getExe pkgs.xclip} -selection clipboard";
      "Ctrl+Shift+v" = "${lib.getExe pkgs.xclip} -selection clipboard -o";
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
