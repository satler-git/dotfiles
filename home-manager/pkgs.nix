{ pkgs, ... }:
let
in
{
  home.packages = with pkgs; [
    gh
    ghq
    lazygit

    aria

    bat
    bibata-cursors

    cabal-install
    clipse

    discord
    deno

    elixir_1_16
    eza

    ghc
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    jq
    jujutsu
    just

    luajit

    # mindustry-server
    mindustry-wayland

    gcc
    ghq

    lutris

    fd
    fzf
    foliate

    playerctl
    pureref

    skk-dicts
    stack
    sqlite
    sqlite.dev
    spacedrive
    spotify

    thunderbird

    unzip
    ueberzugpp

    obsidian
    osu-lazer-bin

    ripgrep
    ripgrep-all
    reversal-icon-theme
    rustup

    hledger

    waydroid
    wl-clipboard

    grim # for screenshot in wayland
    slurp

    yazi

    zellij
    zola
    zoom-us

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
