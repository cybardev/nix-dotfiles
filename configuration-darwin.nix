{
  config,
  pkgs,
  hostName,
  userConfig,
  ...
}:
let
  userName = userConfig.username;
  nixConfigDir = userConfig.nixos;
in
{
  imports = [
    ./system/darwin.nix
  ];

  nixpkgs.hostPlatform = {
    system = "aarch64-darwin";
  };
  networking.computerName = hostName;
  networking.hostName = hostName;

  users.users.${userName} = {
    name = userName;
    home = /Users/${userName};
    shell = pkgs.zsh;
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
