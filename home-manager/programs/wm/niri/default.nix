# https://github.com/natsukium/dotfiles/blob/1f3b67f119a1e07f7df300b850800ec59f23a68c/applications/niri/default.nix
{
  inputs,
  config,
  lib,
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
    "\"yurf --fullscreen launch && disown\""
  ];
  task = [
    "alacritty"
    "--class"
    "yurf"
    "-e"
    "zsh"
    "-c"
    "\"yurf --fullscreen task && disown\""
  ];

  clipse = [
    "alacritty"
    "--class"
    "clipse"
    "-e"
    "clipse"
  ];
in
{
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.niri-flake.homeModules.stylix # Default
    ../waybar
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  programs.niri.settings = {
    binds = defaultKeyBind // {
      "Mod+Return".action.spawn = terminal;
      "Alt+Space".action.spawn = launcher;
      "Alt+Shift+Space".action.spawn = task;

      "Mod+E".action.spawn = fileManager;
      "Mod+V".action.spawn = clipse;

      "Mod+Shift+Q".action =
        if config.programs.wlogout.enable then { spawn = "wlogout"; } else { quit = { }; };
    };
    hotkey-overlay.skip-at-startup = true;
    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus.enable = true;
    };
    spawn-at-startup = [
      { command = [ "fcitx5" ]; }
      {
        command = [
          "clipse"
          "-listen"
        ];
      }
      { command = [ "waybar" ]; }
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      }
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
    ];
    clipboard.disable-primary = true;
  };
}
