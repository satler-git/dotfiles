{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./gh-cli.nix
    ./git
    ./gpg.nix
    ./gtk.nix
    ./i3
    ./jujutsu.nix
    ./neovim
    ./supercollider.nix
    ./tealdeer.nix
    ./wm
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
