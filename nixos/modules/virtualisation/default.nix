{
  imports = [
    ./grimoire.nix
  ];
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableNvidia = true;
    };
    waydroid.enable = true;
    oci-containers.backend = "docker";
    virtualbox.host = {
      enable = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
  };
}
