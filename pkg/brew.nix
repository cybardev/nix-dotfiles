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
    mutableTaps = true;
    taps = tap-set // {
      "jundot/omlx" = inputs.omlx-tap;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = (builtins.attrNames tap-set) ++ [
      {
        name = "jundot/omlx";
        clone_target = "https://github.com/jundot/omlx.git";
      }
    ];
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
      # "rift"
      "omlx"
    ];
    casks = [
      "altserver"
      # "android-studio"
      # "bitwarden"
      "blackhole-16ch"
      # "blender"
      # "coderabbit"
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
      # "keyclu"
      # "krita"
      # "lm-studio"
      "logseq"
      "lulu"
      "lunar-client"
      # "obs"
      # "prusaslicer"
      # "shotcut"
      # "signal"
      "sonic-pi"
      "steam"
      "stremio"
      "ungoogled-chromium"
      # "whisky"
      # "zoom"
    ];
  };
}
