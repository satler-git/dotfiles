{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    packages
    ./packages/git.nix
    ./packages/neovim.nix
    ./packages/wofi.nix
    ./packages/zsh.nix
    ./services/dunst.nix
  ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  wayland.windowManager.hyprland.settings = import ./packages/hyprland.nix { inherit pkgs; };
}
