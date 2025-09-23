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
        allowedTCPPorts = [
          8554 # audio-sharing
        ];
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

    sops = {
      secrets = {
        github_pat = { };
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
      # package = pkgs.lix;

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

        trusted-substituters = [
          "https://ezkea.cachix.org"
          "https://ghostty.cachix.org"
          "https://hyprland.cachix.org"
          "https://miso-haskell.cachix.org"
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://numtide.cachix.org"
          "https://satler.cachix.org"
          "https://yazi.cachix.org"
        ];
        trusted-public-keys = [
          "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "miso-haskell.cachix.org-1:6N2DooyFlZOHUfJtAx1Q09H0P5XXYzoxxQYiwn6W1e8="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "satler.cachix.org-1:qPh5WfP6bZGq/dGK4DsoYRfZqbDAxPwO9l8v+x+ET04="
          "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
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
