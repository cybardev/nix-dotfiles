{
  pkgs,
  nixConfigDir,
  inputs,
  ...
}:
let
  cypkgs = inputs.cypkgs.packages.${pkgs.system};
in
{
  imports = [
    ./common.nix

    ./config/bspwm.nix
  ];

  home = {
    packages = with pkgs; [
      # cypkgs
      cypkgs.logseq

      # nixpkgs
      xorg.xdpyinfo
      nerdfonts
      docker
      unzip
      rustc
      fondo
      feh
      aseprite
      lunar-client
      altserver-linux
    ];
  };

  programs = {
    zsh.shellAliases = {
      fondo = "com.github.calo001.fondo";
      re-nix = "sudo nixos-rebuild switch --flake ${nixConfigDir}#linux";
    };
  };
}
