{ pkgs, ... }:
let
in
{
  home.packages = with pkgs; [
    lazygit

    anki-bin
    aria
    audacity

    bat
    bibata-cursors
    blender
    buf

    cabal-install
    clipse

    discord
    difftastic
    deno
    duckdb

    elixir_1_16
    eva
    eza

    ffmpeg_7-full

    gh
    gh-dash
    gh-poi
    ghc
    ghq
    gimp
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    inkscape

    jq
    jujutsu
    just

    kalker
    kicad
    krita

    luajit

    numbat
    # mindustry-server
    mindustry-wayland
    mpv

    gcc
    ghq
    go-task

    lutris

    fd
    fzf
    foliate

    pandoc
    peazip
    pixelorama
    playerctl
    pureref

    skk-dicts
    stack
    spacedrive
    spotify

    thunderbird
    typst

    unzip
    ueberzugpp

    obsidian
    osu-lazer-bin

    ripgrep
    ripgrep-all
    reversal-icon-theme
    rustup

    hledger

    vlc

    waydroid
    wireshark
    wl-clipboard

    grim # for screenshot in wayland
    slurp

    yazi

    zellij
    zola
    zoom-us
    zoxide

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
