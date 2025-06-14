{ config, lib, ... }:
{
  options.userConfig = lib.mkOption {
    description = "User configuration options";
    type = lib.types.submodule {
      options = {
        isDarwin = lib.mkEnableOption "darwin config";
        nickname = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "User";
          example = "User";
          description = "Nickname of user to display";
        };
        username = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "user";
          example = "user";
          description = "Username of user in system";
        };
        hostname = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "nixos";
          example = "nixos";
          description = "Network hostname for device";
        };
        system = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "x86_64-linux";
          example = "x86_64-linux";
          description = "System architecture";
        };
        locale = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "en_US.UTF-8";
          example = "en_US.UTF-8";
          description = "Device locale for language";
        };
        timezone = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "Etc/UTC";
          example = "Etc/UTC";
          description = "Device timezone";
        };
        configDir = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "/etc/nixos";
          example = "/etc/nixos";
          description = "NixOS config directory";
        };
        homeDir = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "/home/user";
          example = "/home/user";
          description = "Home directory";
        };
        flakePath = lib.mkOption {
          type = lib.types.str;
          default = lib.mkDefault "/etc/nixos";
          example = "/etc/nixos";
          description = "Full path of flake config directory";
        };
      };
    };
  };

  config.userConfig = {
    username = lib.mkDefault "sage";
    hostname = lib.mkDefault "forest";
    system = lib.mkDefault "x86_64-linux";
    nickname = lib.mkDefault "Sheikh";
    locale = lib.mkDefault "en_CA.UTF-8";
    timezone = lib.mkDefault "America/Halifax";
    configDir = lib.mkDefault "~/.config/nixos";
    homeDir = lib.mkDefault (
      (if config.userConfig.isDarwin then "/Users" else "/home") + "/${config.userConfig.username}"
    );
    flakePath = lib.mkDefault (config.userConfig.homeDir + "/.config/nixos");
  };
}
