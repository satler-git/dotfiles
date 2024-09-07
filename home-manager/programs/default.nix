let
  alacritty = ./alacritty.nix;
  git = ./git.nix;
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
    hyprland
    neovim
    waybar
    wofi
    zsh
  ];
}
