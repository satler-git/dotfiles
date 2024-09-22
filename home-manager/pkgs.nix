{ pkgs, ... }:
{
  imports = [
    ./pkgs/chromium.nix
  ];

  home.packages = with pkgs; [
    alacritty-theme
    anki-bin
    aria
    aseprite
    audacity

    bat
    bibata-cursors
    blender
    buf

    cabal-install
    clipse

    deno
    difftastic
    duckdb

    elixir_1_16
    eva
    evcxr
    eza

    ffmpeg_7-full

    gh
    ghc
    ghq
    gimp
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly

    haskellPackages.tidal
    hyprpicker

    imhex
    inkscape

    jq
    jujutsu
    just

    kalker
    kicad
    krita

    lazygit
    logseq
    luajit

    numbat
    nb
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
    playerctl
    # pureref

    skk-dicts
    spacedrive
    stack
    supercollider-with-sc3-plugins

    thunderbird
    typst

    unzip
    ueberzugpp

    osu-lazer-bin
    oxker

    ripgrep
    ripgrep-all
    reversal-icon-theme
    rustup

    hledger

    vlc

    wireshark
    wl-clipboard

    grim # for screenshot in wayland
    slurp

    yazi

    zola
    zoom-us
    zoxide

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
