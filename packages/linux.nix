{ ... }:
{
  home-manager.users.sage =
    { pkgs, ... }:
    {
      imports = [
        ./common.nix

        ./config/bspwm.nix
      ];

      home.packages = with pkgs; [
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

      programs.zsh.shellAliases = {
        fondo = "com.github.calo001.fondo";
        re-nix = "sudo nixos-rebuild switch";
        yup = "sudo nixos-rebuild switch --upgrade";
      };
    };
}
