{ pkgs, ... }:
let
  alacritty = import ./alacritty.nix;
  atuin = import ./atuin.nix;
  git = import ./git.nix;
  gpg = import ./gpg.nix;
  gtk = import ./gtk.nix;
  hyprland = import ./hyprland;
  neovim = import ./neovim.nix;
  waybar = import ./waybar.nix;
  wofi = import ./wofi.nix;
  zsh = import ./zsh.nix;
in
{
  imports = [
    alacritty
    atuin
    git
    gpg
    gtk
    hyprland
    neovim
    waybar
    wofi
    zsh
  ];
}
