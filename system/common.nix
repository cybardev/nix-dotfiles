{ lib, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "signal-desktop"
      "vscode"
    ];

  home-manager.backupFileExtension = "hm.bak";
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
