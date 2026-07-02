{
  pkgs,
  inputs,
  lib,
  ...
}:
with pkgs;
let
  system = pkgs.stdenv.hostPlatform.system;
in
[
  inputs.isd.packages.${system}.default
  inputs.sand.packages.${system}.default

  audacity
  # aider-chat-full
  # android-studio
  aria2
  # audio-sharing

  # blender
  bottom
  brightnessctl

  # calibre
  # charm-freeze
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

  julia-bin

  # gg-jj
  gh
  ghq
  gimp
  gnumake
  gnutar
  go-task
  ghostscript
  graalvmPackages.graalvm-ce
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-ugly
  gst_all_1.gstreamer

  imagemagick
  imhex
  inkscape

  jq

  # kicad
  # koreader
  krita

  libreoffice

  # mindustry-wayland
  maxima
  mission-center
  moonlight-qt
  mpv

  nix-init
  nix-output-monitor
  nix-update
  nix-your-shell
  nixfmt
  nomacs
  numbat

  opam

  p7zip
  pandoc
  playerctl
  podman-compose
  prismlauncher
  pympress

  shotcut
  smartmontools
  spotify
  sops

  teip
  # todoist
  # todoist-electron
  trash-cli
  tre-command
  typos
  typst
  typst-live

  ueberzugpp
  unison-ucm
  unzip

  # osu-lazer-bin
  opencode

  rdfind
  ripgrep
  ripgrep-all
  rquickshare
  # rustdesk-flutter

  hledger
  hyperfine

  vlc

  wireshark
  wakatime-cli
  watchman
  wget
  wxmaxima

  xh

  yazi

  zip
  # zoom-us
  zotero
  zoxide
]
++ ((import ./pkgs/chromium.nix) { inherit pkgs lib; })
