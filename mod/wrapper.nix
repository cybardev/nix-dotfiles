{ config, lib, pkgs, ... }:
let
  cfg = config.local.wrap;
in
{

  options.local.wrap = {
    enable = lib.mkEnableOption "";
    wraps = lib.mkOption {
      default = { };
      type = lib.types.attrsOf (lib.types.submodule ({ name, ... }@wraps: {
        options = {
          enable = lib.mkEnableOption "";
          name = lib.mkOption {
            type = lib.types.str;
            default = name;
          };
          pkg = lib.mkOption {
            type = lib.types.package;
          };
          bins = lib.mkOption {
            default = { };
            type = lib.types.attrsOf (lib.types.submodule ({ name, ... }@bins: {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = name;
                };
                envs = lib.mkOption {
                  type = lib.types.attrsOf (lib.types.submodule ({ name, ... }@envs: {
                    options = {
                      name = lib.mkOption {
                        type = lib.types.str;
                        default = name;
                      };
                      paths = lib.mkOption {
                        default = { };
                        type = with lib.types; attrsOf anything;
                      };
                      finalPathDrvs = lib.mkOption {
                        type = with lib.types; attrsOf package;
                        readOnly = true;
                        default = builtins.mapAttrs
                          (name: value:
                            if builtins.isString value then
                              (pkgs.writeTextDir name value)
                            else
                              (pkgs.runCommand (builtins.baseNameOf name) { } ''
                                d="$out/$(dirname ${name})"
                                mkdir -p "$d"
                                ln -s "${value}" "$d/$(basename ${name})"                                
                              '')
                          )
                          envs.config.paths;
                      };
                      finalDir = lib.mkOption {
                        type = lib.types.package;
                        readOnly = true;
                        default = pkgs.symlinkJoin {
                          name = "wrapped-${wraps.config.name}-${envs.config.name}";
                          paths = builtins.attrValues envs.config.finalPathDrvs;
                        };
                      };
                    };
                  }));
                };
                extraWrapArgs = lib.mkOption {
                  type = lib.types.lines;
                  default = "";
                };
                finalWrapperText = lib.mkOption {
                  type = lib.types.lines;
                  readOnly = true;
                  default = ''
                    wrapProgram "$out/bin/${bins.config.name}" ${lib.optionalString (bins.config.envs != {}) ''\''}
                      ${lib.concatMapAttrsStringSep "\n"
                        (_: env: ''  --set ${env.name} ${env.finalDir} \'')
                        bins.config.envs
                      }
                      ${bins.config.extraWrapArgs}
                  '';
                };
              };
            }));
          };
          addToSystemPackages = (lib.mkEnableOption "") // { default = true; };
          preWrap = lib.mkOption {
            type = lib.types.lines;
            default = "";
          };
          postWrap = lib.mkOption {
            type = lib.types.lines;
            default = "";
          };
          override = lib.mkOption {
            type = with lib.types; oneOf [
              (attrsOf anything)
              (functionTo (attrsOf anything))
            ];
            default = { };
          };
          overrideAttrs = lib.mkOption {
            type = with lib.types; oneOf [
              (attrsOf anyting)
              (functionTo (attrsOf anything))
              (functionTo (functionTo (attrsOf anything)))
            ];
            default = { };
          };
          finalPackage = lib.mkOption {
            type = lib.types.package;
            readOnly = true;
            default = lib.pipe
              (pkgs.callPackage
                (
                  { symlinkJoin, makeWrapper, lib }:
                  symlinkJoin {
                    inherit (wraps.config) name;
                    buildInputs = [
                      makeWrapper
                    ];
                    paths = [
                      wraps.config.pkg
                    ];
                    postBuild = ''
                      ${wraps.config.preWrap}

                      ${lib.concatMapAttrsStringSep
                        "\n"
                        (_: bin: bin.finalWrapperText)
                        wraps.config.bins
                      }

                      ${wraps.config.postWrap}
                    '';
                  }
                )
                { }) [
              (pkg: pkg.overrideAttrs (wraps.config.overrideAttrs))
              (pkg: pkg.override (wraps.config.override))
            ];
          };

        };
      }));
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.pipe cfg.wraps [
      builtins.attrValues
      (builtins.filter (wrapper: wrapper.addToSystemPackages))
      (map (wrapper: wrapper.finalPackage))
    ];
  };
}
