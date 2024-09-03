{ pkgs, ... }:
let

in
{
  home.packages = with pkgs; [
    gh
    ghq
    lazygit

    clipse

    discord

    eza
    ripgrep

    gcc

    lutris

    fzf
    foliate

    spotify

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
