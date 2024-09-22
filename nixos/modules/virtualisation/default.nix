{
  imports = [
    ./grimoire.nix
  ];
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    waydroid.enable = true;
    oci-containers.backend = "docker";
  };
}
