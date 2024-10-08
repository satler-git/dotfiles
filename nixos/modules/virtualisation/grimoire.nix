# Auto-generated using compose2nix v0.2.2.
{ pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers.containers."grimoire" = {
    image = "goniszewski/grimoire:0.4.1-hotfix.2";
    environment = {
      "PORT" = "5173";
      "PUBLIC_HTTPS_ONLY" = "false";
      "PUBLIC_SIGNUP_DISABLED" = "false";
    };
    volumes = [
      "grimoire_grimoire_data:/app/data:rw"
    ];
    ports = [
      "5173:5173/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost:/api/health || exit 1"
      "--health-interval=30s"
      "--health-retries=3"
      "--health-timeout=10s"
      "--network-alias=grimoire"
      "--network=grimoire_default"
    ];
  };
  systemd.services."docker-grimoire" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-grimoire_default.service"
      "docker-volume-grimoire_grimoire_data.service"
    ];
    requires = [
      "docker-network-grimoire_default.service"
      "docker-volume-grimoire_grimoire_data.service"
    ];
    partOf = [
      "docker-compose-grimoire-root.target"
    ];
    wantedBy = [
      "docker-compose-grimoire-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-grimoire_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f grimoire_default";
    };
    script = ''
      docker network inspect grimoire_default || docker network create grimoire_default
    '';
    partOf = [ "docker-compose-grimoire-root.target" ];
    wantedBy = [ "docker-compose-grimoire-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-grimoire_grimoire_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect grimoire_grimoire_data || docker volume create grimoire_grimoire_data
    '';
    partOf = [ "docker-compose-grimoire-root.target" ];
    wantedBy = [ "docker-compose-grimoire-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-grimoire-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
