# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:
let
  boot = ./modules/boot.nix;
  documentation = ./modules/documentation.nix;
  environment = ./modules/environment.nix;
  fonts = ./modules/fonts.nix;
  hardware = ./modules/hardware;
  i18n = ./modules/i18n.nix;
  network = ./modules/network.nix;
  nix = ./modules/nix.nix;
  programs = ./modules/programs.nix;
  services = ./modules/services.nix;
  sops = ./modules/sops.nix;
  stylix = ./modules/stylix.nix;
  systemd = ./modules/systemd.nix;
  time = ./modules/time.nix;
  users = ./modules/users.nix;
  virtualisation = ./modules/virtualisation;
in
{
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05"; # Don't change this
  imports = [
    boot
    documentation
    environment
    fonts
    hardware
    i18n
    network
    nix
    programs
    services
    sops
    stylix
    systemd
    time
    users
    virtualisation
  ];
}
