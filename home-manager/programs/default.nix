{ pkgs, ... }:
{
  imports = [
    # keep-sorted start
    ./alacritty.nix
    ./direnv.nix
    ./gh-cli.nix
    ./ghostty.nix
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
    # keep-sorted end
  ];
}
