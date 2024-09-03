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

    yazi
  ];
}
