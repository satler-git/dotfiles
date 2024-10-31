{ pkgs, inputs, ... }:
let
  packages = import ./pkgs.nix { inherit pkgs inputs; };
  programs = ./programs;
  services = ./services;
  modules = ./modules;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    ./stylix.nix
    packages
    programs
    services
    modules
  ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    sessionVariables = {
      PODMAN_COMPOSE_WARNING_LOGS = "false";
    };
  };
}
