{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    packages
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/wofi.nix
    ./programs/zsh.nix
    ./programs/waybar.nix
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
    settings = import ./programs/hyprland.nix { inherit pkgs; };
  };
}
