let
  secretHome = ../../secrets;
  password = "${secretHome}/password.yaml";
  api-keys = "${secretHome}/api-keys.yaml";
in
{
  sops = {
    defaultSopsFile = password;
    age.keyFile = "/home/satler/.config/sops/age/keys.txt";
    secrets = {
      openweathermap = {
        sopsFile = api-keys;
      };
      wakatime = {
        sopsFile = api-keys;
      };
    };
  };
}
