{
  description = "Flake-based Nix devshell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
  outputs =
    { nixpkgs, ... }:
    let
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: f { pkgs = import nixpkgs { inherit system; }; }
        );
    in
    {
      devShells = forEachSystem (
        { pkgs }:
        {
          default = import ./shell.nix { inherit pkgs; };
        }
      );
    };
}
