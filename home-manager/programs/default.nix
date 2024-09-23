{ pkgs, ... }:
let
  alacritty = import ./alacritty.nix;
  gh = import ./gh-cli.nix;
  git = import ./git.nix;
  gpg = import ./gpg.nix;
  gtk = import ./gtk.nix;
  hyprland = import ./hyprland;
  i3 = import ./i3;
  neovim = import ./neovim.nix;
  waybar = import ./waybar.nix;
  wofi = import ./wofi.nix;
  yazi = import ./yazi.nix;
  zellij = import ./zellij.nix;
  zoxide = import ./zoxide.nix;
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
    i3
    neovim
    waybar
    wofi
    yazi
    zellij
    zoxide
    zsh
  ];
}
