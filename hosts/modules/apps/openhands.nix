{
  pkgs,
  lib,
  config,
  options,
  ...
}:
let
  cfg = config.my.services.openhands;
  img = pkgs.dockerTools.buildImage {
    name = "openhands-app";
    fromImage = pkgs.dockerTools.pullImage {
      imageName = "docker.all-hands.dev/all-hands-ai/openhands";
      imageDigest = "sha256:6475b71c9f8e85eea31fd9c4a6076cb0e5d519ba0091a720185acc74ec513628";
      sha256 = "sha256-viJWs5TNvYm8T6QKMeiP6ubLLGzRofoBbpJN1GTwE8k=";
    };
  };

  runtimeImageBase = pkgs.dockerTools.pullImage {
    imageName = "docker.all-hands.dev/all-hands-ai/runtime";
    imageDigest = "sha256:4ad486814a19e15141111e4e2f0a930cb8ed5d89acce9f51a6d3ae71ac914ec6";
    sha256 = "sha256-t8fcLMPPD0HClP02R3r2SEhAn0WNaq+nq+zEDMbZOa0=";
  };
  runtime-image = pkgs.dockerTools.buildImage {
    name = "openhands-runtime";
    fromImage = runtimeImageBase;

    copyToRoot = pkgs.buildEnv {
      name = "image-root";
      paths = cfg.extraRuntimePackages;
      pathsToLink = [ "/bin" ];
    };
  };

  finalRuntimeImageName = "${runtime-image.buildArgs.name}:${runtime-image.imageTag}";
in
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      my.services.openhands = {
        enable = mkEnableOption "enable OpenHands";
        image = mkOption {
          type = types.package;
          default = img;
        };
        extraRuntimePackages = mkOption {
          type = types.listOf types.package;
          default = [ ];
        };
        extraEnvironmentVariables = mkOption {
          default = { };
          inherit (options.environment.variables) type apply;
        };
        port = mkOption {
          type = types.port;
          default = 3000;
        };
        openFirewall = mkOption {
          type = types.bool;
          default = false;
        };

        datastorePath = lib.mkOption {
          type = lib.types.str;
          default = "/var/lib/openhands";
        };
      };
    };
  config = lib.mkIf cfg.enable {
    # docker run -it --rm --pull=always \
    #     -e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.23-nikolaik \
    #     -e LOG_ALL_EVENTS=true \
    #     -v /var/run/docker.sock:/var/run/docker.sock \
    #     -v ~/.openhands-state:/.openhands-state \
    #     -p 3000:3000 \
    #     --add-host host.docker.internal:host-gateway \
    #     --name openhands-app \
    #     docker.all-hands.dev/all-hands-ai/openhands:0.23
    virtualisation.oci-containers.containers = {
      openhands-app = {
        image = "${cfg.image.buildArgs.name}:${cfg.image.imageTag}";
        imageFile = cfg.image;

        serviceName = "openhands";

        environment = {
          # SANDBOX_RUNTIME_CONTAINER_IMAGE = runtime-image;
          SANDBOX_RUNTIME_CONTAINER_IMAGE = "${finalRuntimeImageName}";
          LOG_ALL_EVENTS = "true";
        } // cfg.extraEnvironmentVariables;

        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "${cfg.datastorePath}/openhands-state:/.openhands-state"
        ];

        ports = [ "127.0.0.1:${builtins.toString cfg.port}:3000" ];

        extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
      };
    };

    system.activationScripts.makeOpenHandsStateDir = {
      text = ''
        mkdir -p ${cfg.datastorePath}/openhands-state
        chmod -R 777 /var/lib/openhands/ # TODO:
      '';
    };

    systemd.services.load-docker-image =
      let
        backend = config.virtualisation.oci-containers.backend;
      in
      {
        description = "Load Docker image";
        after = [ "${backend}.service" ];
        before = [ "openhands.service" ];
        requires = [ "${backend}.service" ];

        path =
          if backend == "docker" then
            [ config.virtualisation.docker.package ]
          else if backend == "podman" then
            [ config.virtualisation.podman.package ]
          else
            throw "Unhandled backend: ${cfg.backend}";

        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "load-docker-image" ''
            if ! ${backend} image inspect ${finalRuntimeImageName} > /dev/null 2>&1; then
              ${backend} load -i ${runtime-image}
            fi
          '';
          RemainAfterExit = true;
        };
        wantedBy = [ "multi-user.target" ];
      };

    networking = lib.mkIf cfg.openFirewall {
      firewall = {
        allowedTCPPorts = [
          cfg.port
        ];
      };
    };

    # TO/DO: cli
  };
}
