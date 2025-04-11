{
  pkgs,
  inputs,
  extraArgs,
  ...
}:
let
  system = pkgs.system;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
  openvsxExt = with extensions.open-vsx; [
    # add Open VSX Registry extensions (pre-release)
    zhuangtongfa.material-theme
    mkhl.direnv
    vscodevim.vim
    tomoki1207.pdf
    adpyke.codesnap
    ms-python.python
    jnoortheen.nix-ide
    charliermarsh.ruff
    ms-vscode.live-server
    myriad-dreamin.tinymist
    echoapi.echoapi-for-vscode
    espressif.esp-idf-extension
    ms-azuretools.vscode-docker
    github.vscode-github-actions
    github.vscode-pull-request-github
  ];
  openvsxReleaseExt = with extensions.open-vsx-release; [
    # add Open VSX Registry extensions (release)
    eamodio.gitlens
  ];
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = openvsxReleaseExt ++ openvsxExt;
      userSettings = {
        "editor.fontFamily" = "'CaskaydiaCove Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "editor.formatOnSave" = true;
        "explorer.sortOrder" = "type";
        "files.autoSave" = "afterDelay";
        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "idf.espIdfPath" = "${extraArgs.home}/Documents/Git/esp/v5.4/esp-idf";
        "idf.gitPath" = "git";
        "idf.hasWalkthroughBeenShown" = true;
        "idf.pythonInstallPath" = "/usr/bin/python3";
        "idf.toolsPath" = "${extraArgs.home}/Documents/Git/esp/.espressif";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "python.languageServer" = "Jedi";
        "vim.smartRelativeLine" = true;
        "update.showReleaseNotes" = false;
        "workbench.colorTheme" = "One Dark Pro Night Flat";
      };
    };
  };
}
