{ ... }:
{
  home-manager.users.sage =
    { pkgs, ... }:
    {
      imports = [
        ./common.nix
      ];

      home = {
        packages = with pkgs; [
          libresprite
          iina
        ];

        file = {
          ".config/aerospace/aerospace.toml".source = ./config/aerospace.toml;
          ".config/karabiner".source = ./config/karabiner;
        };
      };
    };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    masApps = {
      "KeyNote" = 409183694;
      "MuteKey" = 1509590766;
      "OwlFiles" = 510282524;
      # "Xcode" = 497799835;
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
      "karabiner-elements"
      "keyclu"
      "maccy"
      "mark-text"
      # "prusaslicer"
      "sonic-pi"
      # "whisky"
      "zoom"
      # {
      #   name = "wine@staging";
      #   args = {
      #     no_quarantine = true;
      #   };
      # }
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
  };
}
