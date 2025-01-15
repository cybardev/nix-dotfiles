{ ... }:
{
  imports = [
    # linux-surface
    <nixos-hardware/microsoft/surface/common>
  ];
  networking.hostName = "nix-surface"; # Define your hostname.
}
