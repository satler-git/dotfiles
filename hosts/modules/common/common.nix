{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.my;
in
{
  options.my = {
    hostName = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    programs = {
      nix-ld.enable = true;
      git.enable = true;
      vim.enable = true;
      zsh.enable = true;
    };

    time.timeZone = "Asia/Tokyo";

    networking = {
      networkmanager.enable = lib.mkDefault true;

      nameservers = [
        "8.8.8.8"
        "4.4.4.4"
      ];
      hostName = cfg.hostName;

      firewall.enable = lib.mkDefault true;
    };

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 5;
        };
        timeout = 3;
        efi.canTouchEfiVariables = true;
      };
    };

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    security.polkit.enable = true;

    nix = {
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
      };

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
  };
}
