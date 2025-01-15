{ ... }:
{
  imports = [
    <home-manager/nix-darwin>

    ./common.nix

    ../packages/darwin.nix
  ];
}
