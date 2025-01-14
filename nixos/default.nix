{
  config,
  pkgs,
  lib,
  ...
}:
{
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
    ./modules/virtualisation.nix
    # keep-sorted end
  ];
}
