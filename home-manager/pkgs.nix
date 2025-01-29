{ pkgs, inputs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    ./pkgs/chromium.nix
    ./pkgs/anki.nix
  ];

  home.packages = with pkgs; [
    # buildPackages.stdenv.cc
    (fenix.combine [
      fenix.stable.toolchain
      fenix.targets.wasm32-unknown-unknown.stable.rust-std
    ])

    # audacity
    aria

    blender
    bottom

    calibre
    cargo-nextest

    deno
    delta
    duckdb
    duf
    dust

    evcxr

    fd
    ffmpeg_7-full
    foliate
    fzf

    gh
    ghq
    gimp
    gnumake
    gnutar
    graalvm-ce
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer

    imhex
    inkscape
    inputs.cargo-compete.packages.${system}.cargo-compete
    inputs.isd.packages.${system}.default

    jq
    # just

    kicad
    koreader
    krita

    lnav
    lutris

    mindustry-wayland
    mission-center
    mpv

    nix-output-monitor
    nix-your-shell
    nix-init
    nix-update
    # numbat

    p7zip
    pandoc
    playerctl
    podman-compose

    spotify

    tetrio-desktop
    thunderbird
    trash-cli
    tre-command
    typst

    ueberzugpp
    unzip

    osu-lazer-bin

    ripgrep
    ripgrep-all

    hledger

    vlc

    # wireshark
    # wolfram-engine
    wakatime-cli
    watchman
    webcord-vencord
    wego
    wget

    xh

    yazi

    zip
    zoom-us
    zoxide
  ];
}
