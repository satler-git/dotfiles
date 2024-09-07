{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
  programs = import ./programs;
  services = import ./services;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    packages
    programs
    services
  ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
