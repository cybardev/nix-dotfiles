{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # ms-dotnettools.dotnet-interactive-vscode
        ms-dotnettools.vscode-dotnet-runtime
        ms-vscode-remote.remote-containers
        github.vscode-pull-request-github
        # ms-azuretools.vscode-containers
        github.vscode-github-actions
        ms-azuretools.vscode-docker
        zhuangtongfa.material-theme
        # espressif.esp-idf-extension
        # echoapi.echoapi-for-vscode
        njpwerner.autodocstring
        myriad-dreamin.tinymist
        ms-dotnettools.csdevkit
        esbenp.prettier-vscode
        ms-dotnettools.csharp
        ms-vscode.live-server
        dart-code.dart-code
        charliermarsh.ruff
        jnoortheen.nix-ide
        ms-toolsai.jupyter
        humao.rest-client
        continue.continue
        dart-code.flutter
        ms-python.python
        eamodio.gitlens
        adpyke.codesnap
        tomoki1207.pdf
        vscodevim.vim
        mkhl.direnv
      ];
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
        "terminal.integrated.defaultProfile.osx" = "fish";
        "terminal.integrated.defaultProfile.linux" = "fish";

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
