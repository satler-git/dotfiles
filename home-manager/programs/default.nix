{ pkgs, ... }
let
  alacritty = ./alacritty.nix;
  git = ./git.nix;
  gpg = ./gpg.nix;
  hyprland = ./hyprland;
  neovim = ./neovim.nix;
  waybar = ./waybar.nix;
  wofi = ./wofi.nix;
  zsh = ./zsh.nix;
in
{
  imports = [
    alacritty
    git
    gpg
    hyprland
    neovim
    waybar
    wofi
    zsh
  ];
}
