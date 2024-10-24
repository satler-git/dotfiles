{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./gh-cli.nix
    ./git.nix
    ./gpg.nix
    ./gtk.nix
    ./hyprland
    ./i3
    ./jujutsu.nix
    ./neovim.nix
    ./supercollider.nix
    ./taskwarrior.nix
    ./tealdeer.nix
    ./waybar.nix
    ./wofi.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
