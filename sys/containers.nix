{
  config,
  pkgs,
  lib,
  ...
}:
let
  userName = config.userConfig.username;
in
{
  virtualisation = {
    containers = {
      enable = true;
      registries.search = [ "docker.io" ];
    };
    docker = {
      enable = false;
      rootless = {
        enable = false;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "~/.local/docker";
          dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
          registry-mirrors = [ "https://mirror.gcr.io" ];
          pruning = {
            enabled = true;
            interval = "48h";
          };
        };
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };
    };
  };

  users.users.${userName} = {
    extraGroups = [
      # "docker"
      "podman"
    ];

    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];

    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };

  environment = {
    systemPackages = [ pkgs.podman-compose ];
    sessionVariables = {
      PODMAN_COMPOSE_PROVIDER = lib.getExe pkgs.podman-compose;
      PODMAN_COMPOSE_WARNING_LOGS = "false";
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      # NOTE: add containers here
    };
  };
}
