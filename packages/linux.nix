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
        unzip
        rustc
        fondo
        feh
        aseprite
      ];
    };
}
