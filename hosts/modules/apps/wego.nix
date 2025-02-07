{ config, pkgs, ... }:
let
  secretHome = ../../../secrets;
  api-keys = "${secretHome}/api-keys.yaml";
in
{
  sops = {
    secrets = {
      openweathermap = {
        sopsFile = api-keys;
      };
      wakatime = {
        sopsFile = api-keys;
      };
      location = { };
    };
    templates = {
      ".wegorc" = {
        owner = "satler";
        mode = "0600";
        content = ''
          backend=openweathermap
          location=${config.sops.placeholder.location}
          owm-api-key=${config.sops.placeholder.openweathermap}
          owm-lang=ja
        '';
      };
    };
  };

  environment = {
    sessionVariables = {
      WEGORC = "${config.sops.templates.".wegorc".path}";
    };
    systemPackages = [
      pkgs.wego
    ];
  };
}
