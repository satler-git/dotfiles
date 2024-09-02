{ pkgs, ... }:
let

in
{
  home.packages = with pkgs; [
    gh
    ghq
    lazygit

    eza
    ripgrep

    gcc

    lutris

    fzf

    spotify
    slack

    ueberzugpp

    obsidian
    osu-lazer-bin

    hledger

    wl-clipboard

    yazi
  ];
}
