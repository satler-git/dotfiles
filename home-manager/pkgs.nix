{
  pkgs,
  inputs,
  lib,
  ...
}:
with pkgs;
[
  # audacity
  # aider-chat-full
  # android-studio
  aria2
  audio-sharing

  # blender
  bottom

  # calibre
  charm-freeze
  # claude-code
  # code-cursor

  d2
  deno
  delta
  duckdb
  duf
  dust

  elan
  evcxr

  f2
  fd
  ffmpeg_7-full
  foliate
  fzf

  gg-jj
  gh
  ghq
  gimp
  gnumake
  gnutar
  go-task
  graalvmPackages.graalvm-ce
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-ugly
  gst_all_1.gstreamer

  imagemagick
  imhex
  inkscape
  inputs.isd.packages.${system}.default
  inputs.sand.packages.${system}.default

  jq

  # kicad
  koreader
  krita

  lnav

  # mindustry-wayland
  mission-center
  maxima
  mpv

  nix-init
  nix-output-monitor
  nix-update
  nix-your-shell
  nixfmt-rfc-style
  nomacs
  numbat

  opam

  p7zip
  pandoc
  playerctl
  podman-compose
  prismlauncher
  protonplus
  pympress

  smartmontools
  spotify

  teip
  tetrio-desktop
  thunderbird
  # todoist
  todoist-electron
  trash-cli
  tre-command
  typos
  typst
  typst-live

  ueberzugpp
  unzip

  # osu-lazer-bin

  rdfind
  ripgrep
  ripgrep-all
  rquickshare
  # rustdesk-flutter

  hledger
  hyperfine

  vlc

  # wireshark
  wakatime-cli
  watchman
  webcord-vencord
  wget
  wxmaxima

  xh

  yazi

  zip
  zoom-us
  zotero
  zoxide
]
++ ((import ./pkgs/chromium.nix) { inherit pkgs lib; })
