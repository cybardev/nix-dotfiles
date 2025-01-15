{ ... }:
{
  home-manager.users.sage =
    { pkgs, ... }:
    {
      imports = [
        ./common.nix

        ./config/bspwm.nix
        ./config/vscode.nix
      ];

      home.packages = with pkgs; [
        xorg.xdpyinfo
        whitesur-icon-theme
        qogir-icon-theme
        qogir-theme
        nerdfonts
        brave
        rustc
        fondo
        feh
      ];
    };
}
