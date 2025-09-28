let
  raiseVolume = {
    allow-when-locked = true;
    action.spawn = [
      "wpctl"
      "set-volume"
      "@DEFAULT_AUDIO_SINK@"
      "0.1+"
    ];
  };
  lowerVolume = {
    allow-when-locked = true;
    action.spawn = [
      "wpctl"
      "set-volume"
      "@DEFAULT_AUDIO_SINK@"
      "0.1-"
    ];
  };
  mute = {
    allow-when-locked = true;
    action.spawn = [
      "wpctl"
      "set-mute"
      "@DEFAULT_AUDIO_SINK@"
      "toggle"
    ];
  };
  micMute = {
    allow-when-locked = true;
    action.spawn = [
      "wpctl"
      "set-mute"
      "@DEFAULT_AUDIO_SOURCE@"
      "toggle"
    ];
  };
  previous = {
    allow-when-locked = true;
    action.spawn = [
      "playerctl"
      "previous"
    ];
  };
  next = {
    allow-when-locked = true;
    action.spawn = [
      "playerctl"
      "next"
    ];
  };
  play-pause = {
    allow-when-locked = true;
    action.spawn = [
      "playerctl"
      "play-pause"
    ];
  };

  toggle-follow-mode = {
    action.spawn = [
      # "nirius"
      # wrapper of nirius, only toggle when the focusing window is floating
      "myniri"
      "toggle-follow-mode"
    ];
  };

  pick-color = {
    action.spawn-sh = "hyprpicker --no-fancy | tr -d '\n' | wl-copy";
  };

  move = direction: or-action: {
    action.spawn = [
      "myniri"
      "floating-snap-or"
      "-d"
      direction
      or-action
    ];
  };
in
{
  # https://github.com/sodiboo/niri-flake/issues/483
  # Keys consist of modifiers separated by + signs, followed by an XKB key name
  # in the end. To find an XKB name for a particular key, you may use a program
  # like wev.
  #
  # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
  # when running as a winit window.
  #
  # Most actions that you can bind here can also be invoked programmatically with
  # `niri msg action do-something`.

  # Mod-Shift-/, which is usually the same as Mod-?,
  # shows a list of important hotkeys.
  "Mod+Shift+Slash".action.show-hotkey-overlay = { };

  "XF86AudioRaiseVolume" = raiseVolume;
  "XF86AudioLowerVolume" = lowerVolume;
  "XF86AudioMute" = mute;
  "XF86AudioMicMute" = micMute;

  "Mod+F1" = previous;
  "Mod+F2" = next;
  "Mod+F3" = play-pause;

  # HHKBの位置
  "Mod+F6" = raiseVolume;
  "Mod+F7" = lowerVolume;
  "Mod+F8" = mute;
  "Mod+F9" = micMute;

  "Mod+O".action.toggle-overview = { };

  "Mod+Q".action.close-window = { };

  "Mod+H".action.focus-column-or-monitor-left = { };
  "Mod+J".action.focus-window-or-workspace-down = { };
  "Mod+K".action.focus-window-or-workspace-up = { };
  "Mod+L".action.focus-column-or-monitor-right = { };

  "Mod+Shift+H" = move "left" "move-column-left-or-to-monitor-left";
  "Mod+Shift+J" = move "down" "move-window-down-or-to-workspace-down";
  "Mod+Shift+K" = move "up" "move-window-up-or-to-workspace-up";
  "Mod+Shift+L" = move "right" "move-column-right-or-to-monitor-right";

  # Home -> d, End -> g

  "Mod+Home".action.focus-column-first = { };
  "Mod+End".action.focus-column-last = { };
  "Mod+Ctrl+Home".action.move-column-to-first = { };
  "Mod+Ctrl+End".action.move-column-to-last = { };

  "Mod+Ctrl+H".action.focus-monitor-left = { };
  "Mod+Ctrl+J".action.focus-monitor-down = { };
  "Mod+Ctrl+K".action.focus-monitor-up = { };
  "Mod+Ctrl+L".action.focus-monitor-right = { };

  # Alternatively, there are commands to move just a single window:
  # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
  # ...

  # And you can also move a whole workspace to another monitor:
  # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
  # ...

  "Mod+U".action.focus-workspace-down = { };
  "Mod+I".action.focus-workspace-up = { };
  "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
  "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

  # Alternatively, there are commands to move just a single window:
  # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
  # ...

  "Mod+Shift+U".action.move-workspace-down = { };
  "Mod+Shift+I".action.move-workspace-up = { };
  "Mod+Shift+Y".action.move-workspace-to-monitor-left = { };
  "Mod+Shift+O".action.move-workspace-to-monitor-right = { };

  # You can bind mouse wheel scroll ticks using the following syntax.
  # These binds will change direction based on the natural-scroll setting.
  #
  # To avoid scrolling through workspaces really fast, you can use
  # the cooldown-ms property. The bind will be rate-limited to this value.
  # You can set a cooldown on any bind, but it's most useful for the wheel.
  "Mod+WheelScrollDown" = {
    cooldown-ms = 150;
    action.focus-workspace-down = { };
  };
  "Mod+WheelScrollUp" = {
    cooldown-ms = 150;
    action.focus-workspace-up = { };
  };
  "Mod+Ctrl+WheelScrollDown" = {
    cooldown-ms = 150;
    action.move-column-to-workspace-down = { };
  };
  "Mod+Ctrl+WheelScrollUp" = {
    cooldown-ms = 150;
    action.move-column-to-workspace-up = { };
  };

  "Mod+WheelScrollRight".action.focus-column-or-monitor-right = { };
  "Mod+WheelScrollLeft".action.focus-column-or-monitor-left = { };
  "Mod+Ctrl+WheelScrollRight".action.move-column-right-or-to-monitor-right = { };
  "Mod+Ctrl+WheelScrollLeft".action.move-column-left-or-to-monitor-left = { };

  # Usually scrolling up and down with Shift in applications results in
  # horizontal scrolling; these binds replicate that.
  "Mod+Shift+WheelScrollDown".action.focus-column-or-monitor-right = { };
  "Mod+Shift+WheelScrollUp".action.focus-column-or-monitor-left = { };
  "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right-or-to-monitor-right = { };
  "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left-or-to-monitor-left = { };

  # Similarly, you can bind touchpad scroll "ticks".
  # Touchpad scrolling is continuous, so for these binds it is split into
  # discrete intervals.
  # These binds are also affected by touchpad's natural-scroll, so these
  # example binds are "inverted", since we have natural-scroll enabled for
  # touchpads by default.
  #
  "Mod+TouchpadScrollLeft".action.focus-column-or-monitor-left = { };
  "Mod+TouchpadScrollDown".action.focus-window-or-workspace-down = { };
  "Mod+TouchpadScrollUp".action.focus-window-or-workspace-up = { };
  "Mod+TouchpadScrollRight".action.focus-column-or-monitor-right = { };

  "Mod+Shift+TouchpadScrollLeft".action.move-column-left-or-to-monitor-left = { };
  "Mod+Shift+TouchpadScrollDown".action.move-window-down-or-to-workspace-down = { };
  "Mod+Shift+TouchpadScrollUp".action.move-window-up-or-to-workspace-up = { };
  "Mod+Shift+TouchpadScrollRight".action.move-column-right-or-to-monitor-right = { };

  # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
  # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;
  "Mod+Shift+1".action.move-column-to-workspace = 1;
  "Mod+Shift+2".action.move-column-to-workspace = 2;
  "Mod+Shift+3".action.move-column-to-workspace = 3;
  "Mod+Shift+4".action.move-column-to-workspace = 4;
  "Mod+Shift+5".action.move-column-to-workspace = 5;
  "Mod+Shift+6".action.move-column-to-workspace = 6;
  "Mod+Shift+7".action.move-column-to-workspace = 7;
  "Mod+Shift+8".action.move-column-to-workspace = 8;
  "Mod+Shift+9".action.move-column-to-workspace = 9;

  # Alternatively, there are commands to move just a single window:
  # Mod+Ctrl+1 { move-window-to-workspace 1; }

  # Switches focus between the current and the previous workspace.
  "Mod+Tab".action.focus-workspace-previous = { };

  "Mod+Comma".action.consume-window-into-column = { };
  "Mod+Period".action.expel-window-from-column = { };

  # There are also commands that consume or expel a single window to the side.
  # Mod+BracketLeft  { consume-or-expel-window-left; }
  # Mod+BracketRight { consume-or-expel-window-right; }

  "Mod+R".action.switch-preset-column-width = { };
  "Mod+Shift+R".action.reset-window-height = { };
  "Mod+F".action.maximize-column = { };
  "Mod+Shift+F".action.fullscreen-window = { };
  "Mod+Shift+C".action.center-column = { };

  # Finer width adjustments.
  # This command can also:
  # * set width in pixels: "1000"
  # * adjust width in pixels: "-5" or "+5"
  # * set width as a percentage of screen width: "25%"
  # * adjust width as a percentage of screen width: "-10%" or "+10%"
  # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
  # set-column-width "100" will make the column occupy 200 physical screen pixels.
  "Mod+Minus".action.set-column-width = "+10%";
  "Mod+Ctrl+Minus".action.set-column-width = "-10%";

  # Finer height adjustments when in column with other windows.
  "Mod+Shift+Minus".action.set-window-height = "+10%";
  "Mod+Shift+Ctrl+Minus".action.set-window-height = "-10%";

  # Actions to switch layouts.
  # Note: if you uncomment these, make sure you do NOT have
  # a matching layout switch hotkey configured in xkb options above.
  # Having both at once on the same hotkey will break the switching,
  # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
  # Mod+Space       { switch-layout "next"; }
  # Mod+Shift+Space { switch-layout "prev"; }

  "Print".action.screenshot = { };
  "Mod+P".action.screenshot = { };
  "Ctrl+Print".action.screenshot-screen = { };
  "Mod+Ctrl+P".action.screenshot-screen = { };
  "Alt+Print".action.screenshot-window = { };
  "Mod+Alt+P".action.screenshot-window = { };

  "Mod+C" = pick-color;

  # Powers off the monitors. To turn them back on, do any input like
  # moving the mouse or pressing any other key.
  "Mod+Shift+P".action.power-off-monitors = { };

  "Mod+W".action.toggle-column-tabbed-display = { };

  "Mod+G" = toggle-follow-mode;
}
