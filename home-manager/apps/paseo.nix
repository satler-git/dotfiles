{
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = [
    inputs.paseo.packages.${system}.paseo
    inputs.paseo.packages.${system}.desktop
  ];

  home.file.".paseo/config.json".source = ../../config/paseo/config.json;
}
