{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.my;
in
{
  options.my =
    let
      inherit (lib) mkOption types;
    in
    {
      hostName = mkOption {
        type = types.str;
      };
      openFirewall = mkOption {
        type = types.bool;
        default = false;
      };
    };

  config = {
    programs = {
      nix-ld.enable = true;
      git.enable = true;
      neovim.enable = true;
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

      firewall = {
        enable = lib.mkDefault true;
      };
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

    sops =
      let
        secretHome = ../../../secrets;
        api-keys = "${secretHome}/api-keys.yaml";
      in
      {
        secrets = {
          github_pat = {
            sopsFile = api-keys;
          };
        };

        templates = {
          "extra-nix-config" = {
            owner = "satler";
            mode = "0400";
            content = ''
              extra-access-tokens = github.com=${config.sops.placeholder.github_pat}
            '';
          };
        };
      };

    nix = {
      package = pkgs.lix;

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

      extraOptions = ''
        !include ${config.sops.templates."extra-nix-config".path}
      '';

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
