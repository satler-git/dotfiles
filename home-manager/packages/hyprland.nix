{ pkgs, ... }:
{
  # many configs are copied from https://github.com/Comamoca/dotfiles/blob/main/config/home-manager/hyprland.nix
  # Thanks !
  monitor = [
    ",preferred,auto,auto"
    ",preferred,auto,auto"
  ];

  env = [
    "XCURSOR_SIZE,32"
    # "HYPRCURSOR_THEME,MyCursor"
    "HYPRCURSOR_SIZE,25"
    "XCURSOR_SIZE,24"
    # for nvidia, see https://wiki.hyprland.org/Nvidia/
    "LIBVA_DRIVER_NAME,nvidia"
    "XDG_SESSION_TYPE,wayland"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "NVD_BACKEND,direct"
    "ELECTRON_OZONE_PLATFORM_HINT,auto"
  ];

  "$terminal" = "alacritty";
  "$browser" = "firefox";
  "$fileManager" = "alacritty --command=\"yazi\"";
  "$launcher" = "wofi --show drun";

  input = {
    kb_layout = "jp";

    follow_mouse = "0";
    # mouse_refocus = false;
    mouse_refocus = true;

    sensitivity = 0; # -1.0 to 1.0, 0 means no modification.

    accel_profile = "flat";
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
    border_size = 2;
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
    layout = "dwindle";
    allow_tearing = false;
  };

  decoration = {
    rounding = 8;

    blur = {
      enabled = true;
      size = 3;
      passes = 1;
    };
    drop_shadow = "yes";
    shadow_range = 4;
    shadow_render_power = 3;
    "col.shadow" = "rgba(1a1a1aee)";
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
    "float, class:(clipse)"
    "size 622 652, class:(clipse)"
    "opacity 0.8, class:(clipse)"
    "float,class:^(firefox),title:^(ピクチャーインピクチャー)"
    "pin,class:^(firefox),title:^(ピクチャーインピクチャー)"
  ];

  dwindle = {
    pseudotile = "yes";
    preserve_split = "yes";
  };

  misc = {
    force_default_wallpaper = -1;
  };

  gestures = {
    workspace_swipe = "off";
  };

  "$mainMod" = "SUPER";

  bind = [
    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    "$mainMod, Return, exec, $terminal"
    "Alt, Space, exec, $launcher"
    "$mainMod, q, killactive"
    # bind = $mainMod, m, exit,
    "$mainMod, e, exec, $fileManager"
    "$mainMod, f, togglefloating"
    "$mainMod, f, pin,"
    "$mainMod, space, exec, $menu"
    "$mainMod, P, pseudo" # dwindle
    "$mainMod, J, togglesplit," # dwindle
    "$mainMod, b, exec, $browser"
    "$mainMod, v, exec, alacritty --class clipse -e clipse  "
    "Control_L, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"

    # Move focus with mainMod + arrow keys
    "$mainMod, h, movefocus, l"
    "$mainMod, l, movefocus, r"
    "$mainMod, k, movefocus, u"
    "$mainMod, j, movefocus, d"

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

    # Focus workspace with mainMod + Tab + [0-9]
    "$mainMod Tab, 1, focusworkspaceoncurrentmonitor, 1"
    "$mainMod Tab, 2, focusworkspaceoncurrentmonitor, 2"
    "$mainMod Tab, 3, focusworkspaceoncurrentmonitor, 3"
    "$mainMod Tab, 4, focusworkspaceoncurrentmonitor, 4"
    "$mainMod Tab, 5, focusworkspaceoncurrentmonitor, 5"
    "$mainMod Tab, 6, focusworkspaceoncurrentmonitor, 6"
    "$mainMod Tab, 7, focusworkspaceoncurrentmonitor, 7"
    "$mainMod Tab, 8, focusworkspaceoncurrentmonitor, 8"
    "$mainMod Tab, 9, focusworkspaceoncurrentmonitor, 9"
    "$mainMod Tab, 0, focusworkspaceoncurrentmonitor, 10"

    # Example special workspace (scratchpad)
    "$mainMod, w, togglespecialworkspace, magic"
    "$mainMod SHIFT, w, movetoworkspace, special:magic"

    "$mainMod, p, workspace, +1, focuswindow"
    "$mainMod, n, workspace, -1, focuswindow"

    "$mainMod SHIFT, p, movetoworkspace, +1"
    "$mainMod SHIFT, n, movetoworkspace, -1"

    "$mainMod SHIFT, l, movewindow, r"
    "$mainMod SHIFT, h, movewindow, l"

    # Change window size
    "$mainMod ctrl, l, resizeactive, 100 100"
    "$mainMod ctrl, h, resizeactive, -100 100"
  ];

  exec-once = [
    "fcitx5"
    "clipse -listen"
  ];

}
