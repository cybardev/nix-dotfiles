{
  config,
  pkgs,
  inputs,
  ...
}:
let
  hostName = config.userConfig.hostname;
  userName = config.userConfig.username;
  nixConfigDir = config.userConfig.configDir;
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../pkg/brew.nix
    ./nixcommand.nix
    ../mod/userconfig.nix
  ];

  userConfig.isDarwin = true;

  nixpkgs.hostPlatform = {
    system = config.userConfig.system;
  };
  networking.computerName = hostName;
  networking.hostName = hostName;

  system.primaryUser = userName;

  users.users.${userName} = {
    name = userName;
    home = /. + config.userConfig.homeDir;
    shell = pkgs.zsh;
  };

  nix = {
    optimise.interval = {
      Hour = 0;
      Minute = 0;
      Weekday = 0;
    };
    gc.interval = {
      Hour = 0;
      Minute = 0;
      Weekday = 0;
    };
  };

  environment = {
    variables = {
      HOMEBREW_NO_ANALYTICS = "1";
    };

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = [
      # pkgs.vim
    ];

    # Use custom location for configuration.nix.
    darwinConfig = "${nixConfigDir}/configuration-darwin.nix";
  };

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
