{ config, ... }:
let
  secretHome = ../../secrets;
  secrets = "${secretHome}/secrets.yaml";
in
{
  sops = {
    defaultSopsFile = secrets;
    age.keyFile = "/home/satler/.config/sops/age/keys.txt";

    secrets.OPENROUTER_API_KEY = {
      sopsFile = "${secretHome}/api-keys.yaml";
      mode = "0400";
      owner = "${config.users.users.satler.name}";
    };
  };
}
