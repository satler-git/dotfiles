{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
#  extPackages = import ./extraPkgs.nix;
in
{
  imports = [
    packages
    ./packages/git.nix
    ./packages/neovim.nix
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
