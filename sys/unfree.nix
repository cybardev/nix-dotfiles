{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "signal-desktop"
      "freej2me"
      "aseprite"
      "raycast"
      "vscode"
      "zoom"
      "rar"
    ];
}
