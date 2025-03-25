{ lib, userConfig, ... }:
let
  userName = userConfig.username;
in
{
  imports = [
    ./home.nix
    ../packages/darwin.nix
  ];
  home.homeDirectory = lib.mkDefault /Users/${userName};
}
