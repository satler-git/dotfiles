# https://github.com/natsukium/dotfiles/blob/1f3b67f119a1e07f7df300b850800ec59f23a68c/applications/niri/default.nix
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  defaultKeyBind = import ./keyBind.nix;
  terminal = "alacritty";
  fileManager = [
    "alacritty"
    "-e"
    "zsh"
    "-c"
    "yazi"
  ];
  launcher = [
    "alacritty"
    "--class"
    "yurf"
    "-e"
    "zsh"
    "-c"
    "yurf --fullscreen launch && disown"
  ];
  task = [
    "alacritty"
    "--class"
    "yurf"
    "-e"
    "zsh"
    "-c"
    "yurf --fullscreen task && disown"
  ];
  clipse = [
    "alacritty"
    "--class"
    "clipse"
    "-e"
    "clipse"
  ];
  wallpaper = [
    "sh"
    "-c"
    "swww-daemon"
    "&&"
    "swww"
    "img"
    config.stylix.image
  ];
in
{
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.niri-flake.homeModules.stylix # Default
    ../waybar
    ../wayland.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    swww
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  programs.niri.settings = {
    binds = defaultKeyBind // {
      "Mod+Return".action.spawn = terminal;
      "Alt+Space".action.spawn = launcher;
      "Mod+Space".action.spawn = task;

      "Mod+E".action.spawn = fileManager;
      "Mod+V".action.spawn = clipse;

      "Mod+Shift+Q".action =
        if config.programs.wlogout.enable then { spawn = "wlogout"; } else { quit = { }; };
    };
    hotkey-overlay.skip-at-startup = true;
    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus.enable = true;

      mouse = {
        accel-profile = "flat";
      };
      touchpad.natural-scroll = false;
    };
    spawn-at-startup = [
      { command = [ "fcitx5" ]; }
      {
        command = [
          "clipse"
          "-listen"
        ];
      }
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      }
      # { command = wallpaper; }
    ];
    environment = {
      DISPLAY = ":0";

      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";

      XDG_SESSION_TYPE = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
    };
    prefer-no-csd = true;
    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
      }
      {
        matches = [
          {
            title = "^ピクチャーインピクチャー$";
            app-id = "firefox";
          }
          {
            title = "^Picture-in-Picture$";
            app-id = "firefox";
          }
        ];
        open-floating = true;

        default-column-width.proportion = 0.3;
        default-window-height.proportion = 0.3;
      }
      {
        matches = [
          { app-id = "clipse"; }
          { app-id = "yurf"; }
        ];

        open-floating = true;
        open-focused = true;
        opacity = 0.8;

        default-column-width.fixed = 622;
        default-window-height.fixed = 652;
      }
      {
        matches = [
          {
            app-id = "steam";
            title = "^notificationtoasts_\d+_desktop$";
          }
        ];
        default-floating-position = {
          relative-to = "bottom-right";
          x = 10;
          y = 10;
        };
      }
    ];

    layer-rules = [
      {
        matches = [
          { namespace = "^wallpaper$"; }
          { namespace = "^hyprpaper$"; }
          { namespace = "^swww-daemon$"; }
        ];
        place-within-backdrop = true;
      }
      {
        # Hack, see https://yalter.github.io/niri/Application-Issues.html#waybar-and-other-gtk-3-components
        matches = [ { namespace = "^waybar$"; } ];
        opacity = 0.99;
      }
    ];

    layout = {
      background-color = "transparent";

      border.width = 8;
    };
    clipboard.disable-primary = true;
  };
}
