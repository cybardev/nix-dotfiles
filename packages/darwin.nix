{ ... }:
{
  home-manager.users.sage =
    { pkgs, ... }:
    {
      imports = [
        ./common.nix
      ];

      home.packages = with pkgs; [
        iina
      ];

      # Dotfiles
      home.file = {
        # AeroSpace config
        ".config/aerospace/aerospace.toml".text = builtins.readFile (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/cybardev/dotfiles/a3aa064394034f9b4d3f3e702d470e2d633bd124/config/aerospace/aerospace.toml";
            hash = "sha256-ZaGhHMYvH/9jGFo7iUiExYZJQjuGXDd89aiUIKKHrZc=";
          }
        );
      };
    };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    masApps = {
      "OwlFiles" = 510282524;
      "MuteKey" = 1509590766;
      "KeyNote" = 409183694;
    };
    brews = [
      "weasyprint"
    ];
    casks = [
      "aerospace"
      "docker"
      "font-caskaydia-cove-nerd-font"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-open-dyslexic-nerd-font"
      "gb-studio"
      "hiddenbar"
      "keyclu"
      "mark-text"
      "sonic-pi"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
  };
}
