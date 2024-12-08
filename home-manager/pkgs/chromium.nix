{ pkgs, lib, ... }: # TODO: desktopエントリは上書きされないからCLIから実行する必要がある
let
  # ref: https://discourse.nixos.org/t/how-to-write-a-electron-app-wrap-function/40581
  wrap =
    { appName }:
    pkgs.symlinkJoin {
      name = appName;
      paths = [ pkgs.${appName} ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = lib.strings.concatStrings [
        "wrapProgram $out/bin/"
        appName
        " --add-flags \"--enable-webrtc-pipewire-capturer\""
        " --add-flags \"--enable-features=WaylandWindowDecorations\""
        " --add-flags \"--enable-wayland-ime\""
      ];
    };

  discord = wrap { appName = "discord"; };
  google-chrome = pkgs.symlinkJoin {
    name = "google-chrome-stable";
    paths = [ pkgs.google-chrome ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = lib.strings.concatStrings [
      "wrapProgram $out/bin/"
      "google-chrome-stable"
      " --add-flags \"--enable-webrtc-pipewire-capturer\""
      " --add-flags \"--enable-features=WaylandWindowDecorations\""
      " --add-flags \"--enable-wayland-ime\""
    ];
  };

  obsidian = wrap { appName = "obsidian"; };
  slack = wrap { appName = "slack"; };
in
# spotify = wrap { appName = "spotify"; };
{
  home.packages = [
    # discord
    google-chrome
    obsidian
    slack
  ];
}
