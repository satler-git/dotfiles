{ config, pkgs, ... }:
{
  sops = {
    secrets = {
      openweathermap = { };
      wakatime = { };
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
