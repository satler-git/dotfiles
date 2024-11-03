{ config, ... }:
let
  secretHome = ../../secrets;
  password = "${secretHome}/password.yaml";
  secrets = "${secretHome}/secrets.yaml";
  api-keys = "${secretHome}/api-keys.yaml";
in
{
  sops = {
    defaultSopsFile = secrets;
    age.keyFile = "/home/satler/.config/sops/age/keys.txt";
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
        content = ''
          backend=openweathermap
          location=${config.sops.placeholder.location}
          owm-api-key=${config.sops.placeholder.openweathermap}
        '';
      };
    };
  };
}
