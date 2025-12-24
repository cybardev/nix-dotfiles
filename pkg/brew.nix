{ config, inputs, ... }:
let
  tap-set = with inputs; {
    "homebrew/homebrew-core" = homebrew-core;
    "homebrew/homebrew-cask" = homebrew-cask;
    # "acsandmann/homebrew-tap" = rift-wm;
  };
in
{
  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    enableRosetta = true;
    user = config.userConfig.username;
    mutableTaps = false;
    taps = tap-set;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = builtins.attrNames tap-set;
    masApps = {
      # "iMovie" = 408981434;
      "KeyNote" = 409183694;
      "MuteKey" = 1509590766;
      "OwlFiles" = 510282524;
      # "Pages" = 409201541;
      # "Wavebar" = 6450398808;
      "Xcode" = 497799835;
      # "Reins" = 6739738501;
    };
    brews = [
      "cocoapods"
      # "handbrake"
      # "rift"
    ];
    casks = [
      "altserver"
      # "android-studio"
      "blackhole-16ch"
      # "blender"
      "coderabbit"
      # "diffusionbee"
      "discord"
      "docker-desktop"
      # "flutter"
      # "fedora-media-writer"
      "font-caskaydia-cove-nerd-font"
      # "font-fira-code-nerd-font"
      # "font-jetbrains-mono-nerd-font"
      # "font-opendyslexic-nerd-font"
      "gb-studio"
      "gimp"
      "hiddenbar"
      # "karabiner-elements"
      "katrain"
      "keyclu"
      # "krita"
      "lm-studio"
      "logseq"
      "lulu"
      "lunar-client"
      # "obs"
      # "prusaslicer"
      # "shotcut"
      # "signal"
      # "sonic-pi"
      "steam"
      "stremio"
      "ungoogled-chromium"
      # "whisky"
      # "zoom"
    ];
  };
}
