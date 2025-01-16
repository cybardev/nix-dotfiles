{ pkgs, ... }:
{
  programs.vscode =
    let
      system = builtins.currentSystem;
      extensions =
        (import (
          builtins.fetchGit {
            url = "https://github.com/nix-community/nix-vscode-extensions";
            ref = "refs/heads/master";
            rev = "8b588e6f4abddf424702dee267d9b3159f5d1dd6";
          }
        )).extensions.${system};
      openvsxExt = with extensions.open-vsx-release; [
        # add Open VSX Registry extensions
        zhuangtongfa.material-theme
        vscodevim.vim
      ];
      marketplaceExt = with extensions.vscode-marketplace-release; [
        # add VS Code Marketplace extensions
      ];
    in
    {
      enable = true;
      package = pkgs.vscodium;
      extensions = marketplaceExt ++ openvsxExt;
    };
}
