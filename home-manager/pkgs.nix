{ pkgs, inputs, ... }:
let
  superdirt-install = inputs.tidalcycles.packages.x86_64-linux.superdirt-install;
in{
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

    fd
    ffmpeg_7-full
    foliate
    fzf

    gcc
    gh
    ghc
    ghq
    ghq
    gimp
    go-task
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
    lutris

    # mindustry-server
    mindustry-wayland
    mpv
    nb
    numbat

    pandoc
    peazip
    playerctl
    # pureref

    skk-dicts
    spacedrive
    stack
    supercollider-with-sc3-plugins
    superdirt-install

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
    wolfram-engine

    grim # for screenshot in wayland
    slurp

    xclip

    yazi

    zola
    zoom-us
    zoxide

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
