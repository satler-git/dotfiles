{ pkgs, ... }:
{
  imports = [
    # keep-sorted start
    ./alacritty.nix
    ./direnv.nix
    ./gh-cli.nix
    ./ghostty.nix
    ./git
    ./gtk.nix
    ./jujutsu.nix
    ./kalker.nix
    ./keybase.nix
    ./neovim
    ./supercollider.nix
    ./tealdeer.nix
    ./wm/hyprland
    ./wm/i3
    ./wm/wlogout.nix
    ./yazi.nix
    ./zsh.nix
    # keep-sorted end
  ];
}
