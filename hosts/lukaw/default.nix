{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{
  imports = [
    ../modules/home-manager.nix

    inputs.nixos-wsl.nixosModules.wsl
  ];

  system.stateVersion = "24.05"; # Don't change this

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "lukaw";

  wsl = {
    enable = true;
    defaultUser = "satler";
  };

  users = {
    users.satler = {
      isNormalUser = true;
      description = "satler";
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
      initialHashedPassword = "$y$j9T$jrEwC7ZZUCFpS16P4/3l0/$4nLI6Jn5rqjE3dJ702AcPJPPvP6GRMvFMqH3on4FCm4";
    };
  };

  home-manager = {
    users.satler = ../../home-manager/wsl.nix;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };

  nix = {
    settings = {
      trusted-users = [
        "root"
        "satler"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs = {
    git.enable = true;
    neovim.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
  };
}
