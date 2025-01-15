{ ... }:
{
  imports = [
    <home-manager/nix-darwin>

    ../packages/darwin.nix
  ];

  home-manager.imports = [
    ./common.nix
  ];
}
