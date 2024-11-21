{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "24.05"; # Don't change this
  imports = [
    ./modules/boot.nix
    ./modules/documentation.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/hardware
    ./modules/i18n.nix
    ./modules/network.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/sops.nix
    ./modules/stylix.nix
    ./modules/systemd.nix
    ./modules/time.nix
    ./modules/users.nix
    ./modules/virtualisation
  ];
}
