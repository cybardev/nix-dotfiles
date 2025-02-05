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
      openvsxExt = with extensions.open-vsx; [
        # add Open VSX Registry extensions
        zhuangtongfa.material-theme
        vscodevim.vim
        eamodio.gitlens
        adpyke.codesnap
        ms-python.python
        charliermarsh.ruff
        jnoortheen.nix-ide
      ];
      marketplaceExt = with extensions.vscode-marketplace; [
        # add VS Code Marketplace extensions
      ];
    in
    {
      enable = true;
      package = pkgs.vscodium;
      extensions = marketplaceExt ++ openvsxExt;
      userSettings = {
        "editor.fontFamily" = "'CaskaydiaCove Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "editor.formatOnSave" = true;
        "files.autoSave" = "afterDelay";
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
        "workbench.colorTheme" = "One Dark Pro Darker";
      };
    };
}
