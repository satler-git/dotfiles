{
  pkgs,
  lib,
  config,
  ...
}:
{
  # TODO: add age key and gpg key

  imports = [
    ./hardware.nix
    ./hardware-configurations.nix

    ../modules/common/desktop

    ../modules/home-manager.nix
    ../modules/sops.nix
    ../modules/stylix.nix
    ../modules/xremap.nix

    ../modules/users/satler.nix

    ./apps.nix
  ];

  system.stateVersion = "24.11"; # Don't change this

  my.hostName = "tau";

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-session --asterisks --cmd ${lib.getExe config.programs.hyprland.package}";
        user = "satler";
      };
    };
  };
}
