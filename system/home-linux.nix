{ lib, ... }:
{
  imports = [
    ./home.nix
    ../packages/linux.nix
  ];
  home.homeDirectory = lib.mkDefault "/home/sage";
}
