{
  pkgs,
  inputs,
  ...
}: {
  _module.args = {
    cypkgs = import inputs.cypkgs {inherit (pkgs) lib callPackage;};
  };
}
