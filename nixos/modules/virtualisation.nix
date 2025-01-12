{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;

      # For compatibles with
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      dockerSocket.enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;

      autoPrune.enable = true;
    };
    oci-containers.backend = "podman";
  };
}
