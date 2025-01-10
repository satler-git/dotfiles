{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./gh-cli.nix
    ./git
    ./gpg.nix
    ./gtk.nix
    ./jujutsu.nix
    ./kalker.nix
    ./neovim
    ./supercollider.nix
    ./tealdeer.nix
    ./wm/hyprland
    ./wm/i3
    ./yazi.nix
    ./zsh.nix
  ];
}
