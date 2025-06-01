{ inputs, ... }:
{
  nixpkgs.overlays = with inputs; [
    cypkgs.overlays.default
    rust-overlay.overlays.default
    nix-vscode-extensions.overlays.default
  ];
}
