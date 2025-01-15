{ ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.imports = [
    ./common.nix
  ];
  home-manager.users.sage.imports = [
    ../packages/linux.nix
  ];
}
