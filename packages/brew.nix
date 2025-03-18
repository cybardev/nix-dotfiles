{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    masApps = {
      "iMovie" = 408981434;
      "KeyNote" = 409183694;
      "MuteKey" = 1509590766;
      "OwlFiles" = 510282524;
      "Wavebar" = 6450398808;
      # "Xcode" = 497799835;
    };
    brews = [
      "mas"
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
      "steam"
      "whisky"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
  };
}
