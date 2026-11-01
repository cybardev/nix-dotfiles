{ pkgs, config, ... }:
let
  userName = config.userConfig.username;
  substituters = [
    "https://cache.nixos.org"
    "https://cache.nixos.org/"
    "https://cybardev.cachix.org"
  ];
in
{
  nix = {
    package = pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      trusted-users = [ userName ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 524288000;
      inherit substituters;
      trusted-substituters = substituters;
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cybardev.cachix.org-1:WmMM427GHxll9DQEkdSBmzCksQeuJL4h7LIq3MuHg2Q="
      ];
    };
  };
}
