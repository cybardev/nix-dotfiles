{ config, ... }:
{
  imports = [
    # linux-surface
    <nixos-hardware/microsoft/surface/common>

    ./configuration.nix
  ];
}
