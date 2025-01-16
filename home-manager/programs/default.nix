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
    ./keybase.nix
    ./jujutsu.nix
    ./kalker.nix
    ./neovim
    ./supercollider.nix
    ./tealdeer.nix
    ./wm/hyprland
    ./wm/wlogout.nix
    ./wm/i3
    ./yazi.nix
    ./zsh.nix
    # keep-sorted end
  ];
}
