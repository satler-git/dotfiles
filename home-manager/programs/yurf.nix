{ inputs, pkgs, ... }:
let
  writeShellScript = name: content: builtins.toString (pkgs.writeShellScript name content);

  sunsetr_preset = name: {
    name = "sunsetr: active preset (${name})";
    command = "sunsetr preset ${name}";
  };
in
{
  imports = [
    inputs.yurf.homeManagerModules.yurf
  ];

  programs.yurf = {
    enable = true;

    task = [
      {
        name = "hyprsunset: reset";
        command = "hyprctl hyprsunset identity";
        show_if = "[ \"$XDG_CURRENT_DESKTOP\" = \"hyprland\" ]";
      }
      {
        name = "hyprsunset: sunset";
        command = "hyprctl hyprsunset temperature 2500";
        show_if = "[ \"$XDG_CURRENT_DESKTOP\" = \"hyprland\" ]";
      }
      {
        name = "Take a screen capture (Select, Wayland)";
        command = writeShellScript "screen-capture-select" "grim -g \"$(slurp -d)\" - | wl-copy; dunstify \"A rect screenshot is copied!\"";
      }
      {
        name = "Take a screen capture (Active Window, Hyprland)";
        command = writeShellScript "screen-capture-window" "hyprctl -j activewindow | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"' | grim -g - - | wl-copy; dunstify \"A winwdow screenshot is copied!\"";
        show_if = "[ \"$XDG_CURRENT_DESKTOP\" = \"hyprland\" ]";
      }
      {
        name = "Enable Airplane Mode";
        command = "rfkill block all";
      }
      {
        name = "Disable Airplane Mode";
        command = "rfkill unblock all";
      }
      (sunsetr_preset "day")
      (sunsetr_preset "default")
    ];
  };
}
