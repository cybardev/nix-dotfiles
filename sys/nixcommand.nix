{
  config,
  pkgs,
  ...
}:
let
  userName = config.userConfig.username;
in
{
  nix = {
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
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
    };
  };
}
