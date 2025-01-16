{ lib, ... }:
{
  home-manager.backupFileExtension = "hm.bak";
  home-manager.useUserPackages = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];
}
