{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      vscodevim.vim
    ];
  };
}
