{ config, ... }:
let
  secretHome = ../../secrets;
  secrets = "${secretHome}/secrets.yaml";
in
{
  sops = {
    defaultSopsFile = secrets;
    age.keyFile = "/home/satler/.config/sops/age/keys.txt";

    secrets = {
      magit_token = { };
      latitude = { };
      longitude = { };
    };

    templates.authinfo = {
      # Emacs magit/forge
      owner = "satler";
      path = "/home/satler/.authinfo";
      content = ''
        machine api.github.com login satler-git^forge password ${config.sops.placeholder.magit_token}
      '';
    };

    templates.sunsetr-geo = {
      # Emacs magit/forge
      owner = "satler";
      path = "/home/satler/.config/sunsetr/geo.toml";
      content = ''
        latitude = ${config.sops.placeholder.latitude}
        longitude = ${config.sops.placeholder.longitude}
      '';
    };
  };
}
