{
  pkgs,
  inputs,
  extraArgs,
  userConfig,
  ...
}:
let
  cypkgs = import inputs.cypkgs { inherit pkgs; };
  linuxFlake = if extraArgs.surfaceKernel then "linux-surface" else "linux";
  nixConfigDir = userConfig.nixConfigDir;
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
      edit-wm = "nvim ${nixConfigDir}/packages/config/bspwm.nix";
      re-nix = "sudo -H nixos-rebuild switch --flake ${nixConfigDir}#${linuxFlake}";
      re-hm = "home-manager switch --flake ${nixConfigDir}#${linuxFlake}";
    };
  };
}
