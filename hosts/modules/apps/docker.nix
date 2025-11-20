{
  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        daemon.settings = {
          features.cdi = true;
        };
      };

      daemon.settings = {
        features.cdi = true;
      };
    };
    oci-containers.backend = "docker";
  };
}
