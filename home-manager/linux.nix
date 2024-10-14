{ pkgs, inputs, ... }:
let
  packages = import ./pkgs.nix { inherit pkgs inputs; };
  programs = import ./programs;
  services = import ./services;
  modules = import ./modules;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    packages
    programs
    services
    modules
    ./stylix.nix
  ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
