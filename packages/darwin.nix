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
          # TIP: don't add GUI apps here; use brew instead
        ];

        file = {
          ".config/aerospace/aerospace.toml".source = ./config/aerospace.toml;
          ".config/karabiner".source = ./config/karabiner;
        };
      };

      programs.zsh.shellAliases = {
        re-nix = "darwin-rebuild switch";
      };

      programs.cava.settings.input = {
        method = "portaudio";
        source = "'Background Music'";
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
      "altserver"
      # "background-music"
      "docker"
      "font-caskaydia-cove-nerd-font"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-open-dyslexic-nerd-font"
      "gb-studio"
      "hiddenbar"
      "karabiner-elements"
      "keyclu"
      "lulu"
      "lunar-client"
      "prusaslicer"
      "raycast"
      "sonic-pi"
      "whisky"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
  };
}
