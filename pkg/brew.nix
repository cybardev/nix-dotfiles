{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    masApps = {
      "iMovie" = 408981434;
      "KeyNote" = 409183694;
      "MuteKey" = 1509590766;
      "OwlFiles" = 510282524;
      "Wavebar" = 6450398808;
      # "Xcode" = 497799835;
    };
    brews = [
      "handbrake"
    ];
    casks = [
      "altserver"
      # "background-music"
      "brave-browser"
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
      "obs"
      "ollama"
      "prusaslicer"
      "raycast"
      "shotcut"
      "sonic-pi"
      "steam"
      "whisky"
      "zoom"
    ];
  };
}
