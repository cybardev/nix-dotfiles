{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage =
    { ... }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        extensions = with pkgs.vscode-extensions; [
          zhuangtongfa.material-theme
          vscodevim.vim
        ];
      };
    };
}
