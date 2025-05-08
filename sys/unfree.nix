{lib, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode-extension-ms-vscode-remote-remote-containers"
      "signal-desktop-bin"
      "lunarclient"
      "freej2me"
      "aseprite"
      "raycast"
      "vscode"
      "zoom"
      "rar"
    ];
}
