{
  wayland.windowManager.hyprland.settings = {
    # many configs are copied from https://github.com/Comamoca/dotfiles/blob/main/config/home-manager/hyprland.nix
    # Thanks !

    env = [
      "HYPRCURSOR_THEME,Bibata-Modern-Ice"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"

      "XDG_SESSION_TYPE,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "NIXOS_OZONE_WL,1" # hint for electron apps
    ];

    input = {
      kb_layout = "jp";

      follow_mouse = "0";
      # mouse_refocus = false;
      mouse_refocus = true;

      sensitivity = 0; # -1.0 to 1.0, 0 means no modification.

      accel_profile = "flat";
    };

    "device[syna8020:00-06cb:ce5c-touchpad]" = {
      sensitivity = 0.3;
    };

    cursor = {
      no_hardware_cursors = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 4;
      layout = "dwindle";
      allow_tearing = true;
    };

    decoration = {
      rounding = 8;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
      shadow = {
        range = 4;
        render_power = 3;
      };
    };

    animations = {
      enabled = "yes";
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    windowrulev2 = [
      "float,class:^(firefox),title:^(ピクチャーインピクチャー)"
      "pin,class:^(firefox),title:^(ピクチャーインピクチャー)"
      "size 30% 30%, class:^(firefox),title:^(ピクチャーインピクチャー)"
      "float,class:^(firefox),title:^(Picture-in-Picture)"
      "pin,class:^(firefox),title:^(Picture-in-Picture)"
      "size 30% 30%, class:^(firefox),title:^(Picture-in-Picture)"

      # "immediate, class:^(osu!)$"
      "immediate, class:^(ZenlessZoneZero)$"
      "immediate, class:^(A Dance of Fire and Ice)$"

      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "opacity 0.8, class:(clipse)"

      "float,class:^(FloatingVim)"

      "float, class:(yurf)"
      "size 622 652, class:(yurf)"
    ];

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };

    misc = {
      force_default_wallpaper = -1;
    };

    "$mainMod" = "SUPER";

    "$terminal" = "alacritty";
    "$browser" = "firefox";
    "$fileManager" = "alacritty -e zsh -c yazi";
    "$launcher" = "alacritty --class yurf -e zsh -c \"yurf --fullscreen launch && disown\"";
    "$task" = "alacritty --class yurf -e zsh -c \"yurf --fullscreen task && disown\"";
    "$notifs" =
      "alacritty --class yurf -e zsh -c \"dunstctl history | jq -r '.data[0][].body.data' | sed '/^[[:space:]]*$/d' | yurf --copy --fullscreen stdin\"";

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod, Return, exec, $terminal"
      "Alt, Space, exec, $launcher"
      "$mainMod, Space, exec, $task"
      "$mainMod, q, killactive"
      "$mainMod SHIFT, q, exec, wlogout"
      "$mainMod, e, exec, $fileManager"
      "$mainMod, f, togglefloating"
      "$mainMod, f, pin,"
      "$mainMod, b, exec, $browser"
      "$mainMod, v, exec, alacritty --class clipse -e clipse"
      "$mainMod, n, exec, $notifs"
      "Control_L, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy; dunstify \"A rect screenshot is copied!\""
      "Alt,Print, exec, hyprctl -j activewindow | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"' | grim -g - - | wl-copy; dunstify \"A winwdow screenshot is copied!\""

      # ",Eisu_toggle, exec, ~/.local/bin/vime.sh"

      # Move focus with mainMod + arrow keys
      "$mainMod, h, movefocus, l"
      "$mainMod, Left, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, Right, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, Up, movefocus, u"
      "$mainMod, j, movefocus, d"
      "$mainMod, Down, movefocus, d"

      # bind = $mainMod, g, movefocus, d

      "$mainMod, Tab, cyclenext"
      "$mainMod, Tab SHIFT, cyclenext, prev"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod, w, togglespecialworkspace, magic"
      "$mainMod SHIFT, w, movetoworkspace, special:magic"

      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, Left, movewindow, l"
      "$mainMod SHIFT, j, movewindow, d"
      "$mainMod SHIFT, Down, movewindow, d"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, Right, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, Up, movewindow, u"

      # Change window size
      "$mainMod ctrl, h, resizeactive, -100 0"
      "$mainMod ctrl, Left, resizeactive, -100 0"
      "$mainMod ctrl, j, resizeactive, 0 100"
      "$mainMod ctrl, Down, resizeactive, 0 100"
      "$mainMod ctrl, k, resizeactive, 0 -100"
      "$mainMod ctrl, Up, resizeactive, 0 -100"
      "$mainMod ctrl, l, resizeactive, 100 0"
      "$mainMod ctrl, Right, resizeactive, 100 0"

      "$mainMod , F1, exec, playerctl previous"
      "$mainMod , F2, exec, playerctl next"
      "$mainMod , F3, exec, playerctl play-pause"
    ];

    # map media keys
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

    bindl = [
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPlay, exec, playerctl play-pause"
    ];

    exec-once = [
      "fcitx5"
      "clipse -listen"
      "waybar"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
