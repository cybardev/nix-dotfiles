{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
  ];

  users.users.sage = {
    name = "sage";
    home = /Users/sage;
  };

  # this allows sharing between nixos and darwin:

  # home-manager.users.sage.imports = [
  #   ./packages/zshrc.nix
  # ];

  home-manager.users.sage = { pkgs, ... }: {
    home.packages = with pkgs; [
      nix-search-cli
      bat
      eza
      cmatrix
      ffmpeg
      gitui
      go
      hugo
      imagemagick
      luajit
      luajitPackages.luarocks
      mpv
      neovim
      p7zip
      pipx
      pnpm
      poppler
      visidata
      weasyprint
      yt-dlp
      # bottom
      # cava
      # yazi
      # love
      # zsh-autosuggestions
      # zsh-history-substring-search
      # zsh-syntax-highlighting
    ];
    # programs.zsh.enable = true;

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
  };
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm.bak";

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

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # vim
  ];

  # Use custom location for configuration.nix.
  environment.darwinConfig = "$HOME/.config/nixos/configuration-darwin.nix";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}

