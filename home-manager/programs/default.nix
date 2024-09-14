{ pkgs, ... }:
let
  alacritty = import ./alacritty.nix;
  gh = import ./gh-cli.nix;
  git = import ./git.nix;
  gpg = import ./gpg.nix;
  gtk = import ./gtk.nix;
  hyprland = import ./hyprland;
  neovim = import ./neovim.nix;
  waybar = import ./waybar.nix;
  wofi = import ./wofi.nix;
  zellij = import ./zellij.nix;
  zsh = import ./zsh.nix;
in
{
  imports = [
    alacritty
    gh
    git
    gpg
    gtk
    hyprland
    neovim
    waybar
    wofi
    zellij
    zsh
  ];
}
