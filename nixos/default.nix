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
  boot = import ./modules/boot.nix;
  environment = import ./modules/environment.nix;
  fonts = import ./modules/fonts.nix;
  hardware = import ./modules/hardware;
  i18n = import ./modules/i18n.nix;
  nix = import ./modules/nix.nix;
  programs = import ./modules/programs.nix;
  services = import ./modules/services.nix;
  systemd = import ./modules/systemd.nix;
  time = import ./modules/time.nix;
  users = import ./modules/users.nix;
  virtualisation = import ./modules/virtualisation;
in
{
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05"; # Don't change this
  imports = [
    boot
    environment
    fonts
    hardware
    i18n
    nix
    programs
    services
    systemd
    time
    users
    virtualisation
    ./modules/stylix.nix
  ];
}
