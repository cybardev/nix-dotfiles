{ inputs, ... }:
{
  nixpkgs.overlays = with inputs; [
    cypkgs.overlays.default
    nix-vscode-extensions.overlays.default
  ];
}
