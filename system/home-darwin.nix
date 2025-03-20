{ lib, userName, ... }:
{
  imports = [
    ./home.nix
    ../packages/darwin.nix
  ];
  home.homeDirectory = lib.mkDefault /Users/${userName};
}
