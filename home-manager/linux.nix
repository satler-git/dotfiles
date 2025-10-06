{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  programs = ./programs;
  services = ./services;
  modules = ./modules;
in
{
  imports = [
    ./apps
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
      "${homeDirectory}/.cargo/bin"
    ];

    packages =
      if ((builtins.getEnv "NIXOS_SKIP_PKGS" != "1")) then
        (import ./pkgs.nix) { inherit pkgs lib inputs; }
      else
        [ ];
  };
}
