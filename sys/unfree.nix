{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode-extension-ms-vscode-remote-remote-containers"
      "vscode-extension-ms-dotnettools-csdevkit"
      "vscode-extension-ms-dotnettools-csharp"
      "signal-desktop-bin"
      "lunarclient"
      "freej2me"
      "aseprite"
      "zsh-abbr"
      "raycast"
      "vscode"
      "zoom"
      "rar"
    ];
}
