{ pkgs, inputs, ... }:
{
  imports = [
    ./pkgs/chromium.nix
    ./pkgs/cargo-compete.nix
    ./pkgs/anki.nix
  ];

  home.packages = with pkgs; [
    # Overlays
    inputs.ghostty.packages.${pkgs.system}.default

    # audacity
    age
    aria

    # blender
    bottom

    calibre
    cabal-install
    cargo-nextest

    deno
    delta
    duckdb
    duf
    dust

    elixir_1_16
    evcxr

    fd
    ffmpeg_7-full
    foliate
    fzf

    gcc
    gh
    ghc
    ghq
    gimp
    gnumake
    gnutar
    graalvm-ce
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer

    haskell-language-server

    imhex
    inkscape

    jq
    # just

    kalker
    # kicad
    koreader
    krita

    luajit
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
    peazip
    playerctl
    podman-compose

    sops
    spotify
    stack

    tetrio-desktop
    thunderbird
    tre-command
    typst

    ueberzugpp
    unzip

    osu-lazer-bin

    ripgrep
    ripgrep-all
    rr
    rustup

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

    zoom-us
    zoxide
  ];
}
