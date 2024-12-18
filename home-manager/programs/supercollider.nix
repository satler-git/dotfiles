{ pkgs, inputs, ... }:
let
  superdirt-install = inputs.tidalcycles.packages.x86_64-linux.superdirt-install;
in
{
  home.packages = with pkgs; [
    haskellPackages.tidal
    supercollider-with-sc3-plugins
    superdirt-install
  ];

  xdg.configFile."SuperCollider/startup.scd" = {
    source = ../../config/SuperCollider/startup.scd;
  };
}
