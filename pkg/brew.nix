{ config, inputs, ... }:
let
  tap-set = with inputs; {
    "homebrew/homebrew-core" = homebrew-core;
    "homebrew/homebrew-cask" = homebrew-cask;
    "mac-brow-app/homebrew-tap" = mac-brow-app;
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
    package = inputs.brew-src // {
      name = "brew-${inputs.brew-src.shortRev}";
      version = inputs.brew-src.shortRev;
    };
  };

  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
      brewfile = true;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = builtins.attrNames tap-set;
    # masApps = {
    #   # "iMovie" = 408981434;
    #   # "KeyNote" = 361285480;
    #   "MuteKey" = 1509590766;
    #   # "Pages" = 361309726;
    #   # "Wavebar" = 6450398808;
    #   "WebSSH" = 497714887;
    #   "Tailscale" = 1475387142;
    #   "Xcode" = 497799835;
    # };
    brews = [
      # "mas"
      "cocoapods"
      # "handbrake"
      # "hermes-agent"
      # "rift"
    ];
    casks = [
      "altserver"
      # "android-studio"
      # "bitwarden"
      # "blackhole-16ch"
      # "blender"
      # "coderabbit"
      # "diffusionbee"
      # "discord"
      # "docker-desktop"
      # "flutter"
      # "fedora-media-writer"
      "font-caskaydia-cove-nerd-font"
      # "font-fira-code-nerd-font"
      # "font-jetbrains-mono-nerd-font"
      # "font-opendyslexic-nerd-font"
      "gb-studio"
      "gimp"
      "helium-browser"
      # "hiddenbar"
      # "karabiner-elements"
      "katrain"
      # "keyclu"
      # "krita"
      # "lm-studio"
      "logseq"
      "lulu"
      # "lunar-client"
      "mac-brow-app/tap/brow"
      # "obs"
      # "prusaslicer"
      # "shotcut"
      # "signal"
      "sonic-pi"
      # "soulseek"
      "steam"
      # "stremio"
      # "ungoogled-chromium"
      # "whisky"
      # "zoom"
    ];
  };
}
