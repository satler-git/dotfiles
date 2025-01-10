{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "24.05"; # Don't change this
  imports = [
    # keep-sorted start
    ./modules/boot.nix
    ./modules/documentation.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    ./modules/i18n.nix
    ./modules/network.nix
    ./modules/nix.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/sops.nix
    ./modules/stylix.nix
    ./modules/systemd.nix
    ./modules/users.nix
    ./modules/virtualisation
    # keep-sorted end
  ];
}
