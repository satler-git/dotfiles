{ config, ... }:
let
  secretHome = ../../secrets;
  secrets = "${secretHome}/secrets.yaml";
in
{
  sops = {
    defaultSopsFile = secrets;
    age.keyFile = "/home/satler/.config/sops/age/keys.txt";
  };
}
