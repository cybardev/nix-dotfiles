{
  pkgs,
  extraArgs,
  userConfig,
  ...
}:
let
  linuxFlake = if extraArgs.surfaceKernel then "linux-surface" else "linux";
  nixConfigDir = userConfig.nixos;
in
{
  imports = [
    ./common.nix

    ./config/bspwm.nix
  ];

  home = {
    packages = with pkgs; [
      xorg.xdpyinfo
      nerdfonts
      docker
      unzip
      rustc
      fondo
      feh
      brave
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
