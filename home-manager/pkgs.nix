{ pkgs, ... }:
let
in
{
  home.packages = with pkgs; [
    gh
    ghq
    lazygit

    bibata-cursors

    clipse

    discord

    eza

    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    jq

    luajit

    ripgrep

    gcc
    ghq

    lutris

    fzf
    foliate

    playerctl
    pureref

    sqlite
    sqlite.dev
    spotify

    thunderbird

    unzip
    ueberzugpp

    obsidian
    osu-lazer-bin

    reversal-icon-theme

    hledger

    waydroid
    wl-clipboard

    grim # for screenshot in wayland
    slurp

    yazi
    ydotool

    zoom-us

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
