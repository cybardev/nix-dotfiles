{ inputs, ... }:
with inputs;
[
  cypkgs.overlays.default
  nix-vscode-extensions.overlays.default
]
