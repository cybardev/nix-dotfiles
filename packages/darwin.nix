{ ... }:
{
  home-manager.users.sage =
    { pkgs, ... }:
    {
      imports = [
        ./common.nix
      ];

      home.packages = with pkgs; [
        pnpm
        pipx
      ];
    };

  homebrew = {
    enable = true;
    brews = [
      # lua
      # luarocks
    ];
    casks = [
      "aerospace"
      "brave-browser"
      "docker"
      "font-caskaydia-cove-nerd-font"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-open-dyslexic-nerd-font"
      "gb-studio"
      "gimp"
      "hiddenbar"
      "iina"
      "inkscape"
      "kitty"
      "keyclu"
      "mark-text"
      "multipatch"
      "sonic-pi"
      "signal"
      "visual-studio-code"
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
