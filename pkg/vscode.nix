{
  pkgs,
  extraArgs,
  ...
}: let
  ext = with pkgs.vscode-marketplace; [
    zhuangtongfa.material-theme
    mkhl.direnv
    vscodevim.vim
    tomoki1207.pdf
    adpyke.codesnap
    ms-python.python
    ms-toolsai.jupyter
    jnoortheen.nix-ide
    charliermarsh.ruff
    ms-vscode.live-server
    myriad-dreamin.tinymist
    njpwerner.autodocstring
    echoapi.echoapi-for-vscode
    espressif.esp-idf-extension
    ms-azuretools.vscode-docker
    github.vscode-github-actions
    github.vscode-pull-request-github
    ms-vscode-remote.remote-containers
  ];
  relExt = with pkgs.vscode-marketplace-release; [
    eamodio.gitlens
  ];
in {
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    profiles.default = {
      extensions = ext ++ relExt;
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
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              command = ["alejandra"];
            };
          };
        };
        "python.languageServer" = "Jedi";
        "vim.smartRelativeLine" = true;
        "update.showReleaseNotes" = false;
        "workbench.colorTheme" = "One Dark Pro Night Flat";
        "workbench.startupEditor" = "none";
      };
    };
  };
}
