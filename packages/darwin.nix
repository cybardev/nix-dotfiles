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
    };

  homebrew = {
    enable = true;
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
      "multipatch"
      "sonic-pi"
      # "android-studio"
      # "background-music"
      # "basictex"
      # "blender"
      # "dropzone"
      # "gamemaker"
      # "godot"
      # "obs"
      # "unity-hub"
      # "utm"
      # "zulu"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      "nikitabobko/tap"
      # "hashicorp/tap"
      # "localstack/tap"
    ];
  };
}
