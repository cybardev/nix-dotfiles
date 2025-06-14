{
  pkgs,
  inputs,
  hostName,
  userConfig,
  extraArgs,
  ...
}:
let
  userName = userConfig.username;
  nixConfigDir = userConfig.nixos;
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../pkg/brew.nix
    ./nixcommand.nix
  ];

  nixpkgs.hostPlatform = {
    system = extraArgs.system;
  };
  networking.computerName = hostName;
  networking.hostName = hostName;

  system.primaryUser = userName;

  users.users.${userName} = {
    name = userName;
    home = /. + extraArgs.home;
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
    systemPackages = with pkgs; [
      # vim
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
