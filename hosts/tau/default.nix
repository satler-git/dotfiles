{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./hardware-configurations.nix

    ../modules/boot/plymouth.nix
    ../modules/boot/secureboot.nix

    ../modules/common/desktop

    ../modules/home-manager.nix
    ../modules/sops.nix
    ../modules/stylix.nix
    ../modules/xremap.nix

    ../modules/users/satler.nix

    ./apps.nix
  ];

  sops = {
    secrets = {
      home_ssid = { };
      home_key = { };
    };

    templates.wifi = {
      content = ''
        HOME_WIFI_SSID=${config.sops.placeholder.home_ssid}
        HOME_WIFI_PASSWORD=${config.sops.placeholder.home_key}
      '';
    };
  };

  networking = {
    networkmanager = {
      wifi.backend = "iwd";

      ensureProfiles = {
        environmentFiles = [ config.sops.templates.wifi.path ];
        profiles = {
          home = {
            connection = {
              id = "$HOME_WIFI_SSID";
              type = "wifi";
            };
            wifi = {
              mode = "infrastructure";
              ssid = "$HOME_WIFI_SSID";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$HOME_WIFI_PASSWORD";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "24.11"; # Don't change this

  my.hostName = "tau";

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "${lib.getExe pkgs.tuigreet} -t -r --remember-session --asterisks --cmd ${lib.getExe config.programs.hyprland.package}"; # niri-session
        command = "${lib.getExe pkgs.tuigreet} -t -r --remember-session --asterisks --cmd niri-session"; # niri-session
        user = "satler";
      };
    };
  };
}
