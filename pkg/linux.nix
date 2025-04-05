{
  pkgs,
  userConfig,
  ...
}:
let
  nixConfigDir = userConfig.nixos;
in
{
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
      re-nix = "sudo -H nixos-rebuild switch --flake ${nixConfigDir}";
    };
  };
}
