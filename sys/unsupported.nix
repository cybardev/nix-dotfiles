{...}: {
  nixpkgs.config = {
    allowBroken = true;
    allowUnsupportedSystem = true;
  };
}
