{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      cy = inputs.cypkgs.legacyPackages.${pkgs.system};
    })
  ];
}
