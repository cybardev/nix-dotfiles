# test packages using `nix-build test.nix`
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {
    allowUnfree = true;
  }; overlays = []; };
in
{
  cutefetch = pkgs.callPackage ./cutefetch.nix { };
  freej2me = pkgs.callPackage ./freej2me.nix { };
  ptpython = pkgs.callPackage ./ptpython.nix { };
  ueli = pkgs.callPackage ./ueli.nix { };
  ytgo = pkgs.callPackage ./ytgo.nix { };
}
