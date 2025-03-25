{ lib, userConfig, ... }:
let
  userName = userConfig.username;
in
{
  imports = [
    ./home.nix
    ../packages/linux.nix
  ];
  home.homeDirectory = lib.mkDefault /home/${userName};
}
