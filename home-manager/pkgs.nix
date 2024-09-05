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

    ripgrep

    gcc

    lutris

    fzf
    foliate

    playerctl
    pureref

    spotify

    unzip
    ueberzugpp

    obsidian
    osu-lazer-bin

    hledger

    wl-clipboard

    grim # for screenshot in wayland
    slurp

    yazi

    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
