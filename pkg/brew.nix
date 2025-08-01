{ config, ... }:
{
  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    enableRosetta = true;
    user = config.userConfig.username;
  };

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
      "Pages" = 409201541;
      "Wavebar" = 6450398808;
      "Xcode" = 497799835;
    };
    brews = [
      "cocoapods"
      "handbrake"
    ];
    casks = [
      "altserver"
      "blackhole-16ch"
      "docker-desktop"
      "flutter"
      "font-caskaydia-cove-nerd-font"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-open-dyslexic-nerd-font"
      "gb-studio"
      "hiddenbar"
      "karabiner-elements"
      "keyclu"
      "logseq"
      "lulu"
      "lunar-client"
      "obs"
      "prusaslicer"
      "raycast"
      "shotcut"
      "signal"
      "sonic-pi"
      "steam"
      "ungoogled-chromium"
      "whisky"
      "zen"
      "zoom"
    ];
  };
}
