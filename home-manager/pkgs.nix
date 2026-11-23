{
  pkgs,
  lib,
  ...
}:
with pkgs;
[
  _1password-gui
  # _1password-cli は programs._1password がシステム側で入れる
  # (setgid ラッパー経由でないと GUI 連携が動かないため)

  ac-library
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
  chatgpt
  clang-tools # clangd, clang-format, clang-tidy
  codex

  d2
  deepseek-harness
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
  fzf

  gamescope

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
  # imhex
  inkscape

  jq

  # kicad
  # koreader
  krita

  libreoffice
  lutris

  # mindustry-wayland
  maxima
  moonlight-qt
  mo-viewer
  mpv

  nix-init
  nix-output-monitor
  nix-update
  nix-your-shell
  nixfmt
  nomacs
  numbat

  onlyoffice-desktopeditors
  opam

  p7zip
  pandoc
  playerctl
  podman-compose
  prismlauncher
  pympress

  scribus
  # shotcut
  smartmontools
  spotify
  sops

  takusu-cli
  # takusu-desktop
  # teip
  # todoist
  # todoist-electron
  tirith
  trash-cli
  tre-command
  typos
  typst
  typst-live

  ueberzugpp
  # inputs.unison-lang.packages.${system}.ucm-bin
  unzip

  # osu-lazer-bin
  rdfind
  ripgrep
  ripgrep-all
  # rquickshare
  # rustdesk-flutter

  herdr
  hledger
  hyperfine

  vlc

  # wireshark
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
