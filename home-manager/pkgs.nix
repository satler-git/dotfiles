{ pkgs, ... }:
let
  ueli = pkgs.callPackage ./packages/ueli/default.nix {  };
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

    playerctl

    spotify

    ueberzugpp
    ueli
    egl-wayland
    glew

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
