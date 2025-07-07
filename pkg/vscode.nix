{
  config,
  pkgs,
  ...
}:
let
  ext = with pkgs.vscode-marketplace; [
    zhuangtongfa.material-theme
    mkhl.direnv
    vscodevim.vim
    tomoki1207.pdf
    adpyke.codesnap
    ms-python.python
    dart-code.flutter
    continue.continue
    humao.rest-client
    # ms-toolsai.jupyter
    jnoortheen.nix-ide
    charliermarsh.ruff
    dart-code.dart-code
    ms-vscode.live-server
    ms-dotnettools.csharp
    esbenp.prettier-vscode
    ms-dotnettools.csdevkit
    myriad-dreamin.tinymist
    njpwerner.autodocstring
    echoapi.echoapi-for-vscode
    espressif.esp-idf-extension
    # ms-azuretools.vscode-docker
    github.vscode-github-actions
    ms-azuretools.vscode-containers
    github.vscode-pull-request-github
    ms-vscode-remote.remote-containers
    ms-dotnettools.vscode-dotnet-runtime
    ms-dotnettools.dotnet-interactive-vscode
  ];
  relExt = with pkgs.vscode-marketplace-release; [
    eamodio.gitlens
  ];
in
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    profiles.default = {
      extensions = ext ++ relExt;
      userSettings = {
        "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "${pkgs.dotnet-sdk_9}/share/dotnet/dotnet";
        "editor.cursorBlinking" = "phase";
        "editor.fontFamily" = "'CaskaydiaCove Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "editor.formatOnSave" = true;
        "explorer.sortOrder" = "type";
        "files.autoSave" = "afterDelay";
        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "idf.espIdfPath" = "${config.userConfig.homeDir}/Documents/Git/esp/v5.4/esp-idf";
        "idf.gitPath" = "git";
        "idf.hasWalkthroughBeenShown" = true;
        "idf.pythonInstallPath" = "/usr/bin/python3";
        "idf.showOnboardingOnInit" = false;
        "idf.toolsPath" = "${config.userConfig.homeDir}/Documents/Git/esp/.espressif";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              command = [ "nixfmt" ];
            };
          };
        };
        "python.languageServer" = "Jedi";
        "vim.smartRelativeLine" = true;
        "update.showReleaseNotes" = false;
        "workbench.colorTheme" = "One Dark Pro Night Flat";
        "workbench.startupEditor" = "none";

        # disable telemetry
        "idf.telemetry" = false;
        "telemetry.telemetryLevel" = "off";
        "gitlens.telemetry.enabled" = false;
        "telemetry.feedback.enabled" = false;
        "rest-client.enableTelemetry" = false;
        "dotnetAcquisitionExtension.enableTelemetry" = false;
        "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };
    };
  };
}
