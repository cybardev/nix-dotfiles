{
  description = "Flake-based Nix devshell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: f { pkgs = import nixpkgs { inherit system; }; });
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
