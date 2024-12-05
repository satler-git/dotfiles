{ pkgs, inputs, ... }:
let
  programs = ./programs;
  services = ./services;
  modules = ./modules;
in
{
  imports = [
    ./pkgs.nix
    ./stylix.nix
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

    sessionPath = [
      "~/.cargo/bin"
    ];
  };
}
