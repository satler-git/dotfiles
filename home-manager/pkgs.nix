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

    osu-lazer-bin

    hledger

    wl-clipboard

    yazi
  ];
}
