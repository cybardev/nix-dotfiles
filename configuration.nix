# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.11.tar.gz"), ... }: {
  imports = [
    # linux-surface
    <nixos-hardware/microsoft/surface/common>

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Home Manager
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "azure"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Halifax";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sage = {
    isNormalUser = true;
    description = "Sheikh";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.sage = { lib, ... }: {
    home.packages = with pkgs; [
      xorg.xdpyinfo
      qogir-icon-theme
      qogir-theme
      nerdfonts
      ffmpeg
      yt-dlp
      neovim
      gitui
      rustc
      brave
      pipx
      mpv
      bat
      go
    ];

    # set $EDITOR to nvim
    home.sessionVariables.EDITOR = "nvim";

    # Poetry for Python
    programs.poetry = {
      enable = true;
      settings.virtualenvs.in-project = true;
    };

    # Bottom
    programs.bottom = {
      enable = true;
      settings.styles.theme = "nord";
    };

    # Git
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "cybardev";
      userEmail = "sheikh@cybar.dev";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";
      };
    };

    # Z-shell
    programs.zsh = {
      dotDir = ".config/zsh";
      enable = true;
      autocd = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      autosuggestion.enable = true;
      autosuggestion.strategy = [ "history" "completion" "match_prev_cmd" ];
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      history = {
        save = 1024;
        size = 2048;
        share = true;
        append = true;
        ignoreAllDups = true;
        path = "$ZDOTDIR/history";
      };
      initExtra = ''
        path+=( "$(go env GOPATH)/bin" "$HOME/.local/bin" )
        cutefetch

        fpath+="$ZDOTDIR/zen"
        autoload -Uz promptinit
        promptinit
        prompt zen

        function etch() {
          sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync
        }
      '';
      shellAliases = {
        # shell conveniences
        x = "exit";
        cf = "cutefetch";
        clr = "clear";
        cls = "clear";

        # editing related
        edit = "nvim";
        edit-vim = "nvim ~/.config/nvim/lua/plugins/user.lua";
        edit-os = "nvim ~/.config/nixos/configuration.nix";

        # reloading configs
        rebuild-os = "sudo nixos-rebuild switch";
        zrc = ". $ZDOTDIR/.zshrc";

        # package management
        yin = "nix-shell -p";
        yang = "nix-search";
        yup = "sudo nixos-rebuild switch --upgrade";
      };
    };

    # File Manager
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "fm";
      settings = {
        manager = {
          sort_by = "extension";
          sort_dir_first = true;
        };
        opener.text = [
          { run = "$EDITOR '$@'"; block = true; for = "unix"; }
        ];
      };
      initLua = ''
        require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true })
      '';
      keymap = {
        manager.prepend_keymap = [
          { run = "plugin relative-motions --args=1"; on = [ "1"]; }
          { run = "plugin relative-motions --args=2"; on = [ "2"]; }
          { run = "plugin relative-motions --args=3"; on = [ "3"]; }
          { run = "plugin relative-motions --args=4"; on = [ "4"]; }
          { run = "plugin relative-motions --args=5"; on = [ "5"]; }
          { run = "plugin relative-motions --args=6"; on = [ "6"]; }
          { run = "plugin relative-motions --args=7"; on = [ "7"]; }
          { run = "plugin relative-motions --args=8"; on = [ "8"]; }
          { run = "plugin relative-motions --args=9"; on = [ "9"]; }
        ];
      };
    };

    # Kitty Terminal
    programs.kitty = {
      enable = true;
      themeFile = "DarkOneNuanced";
      settings = {
        shell = "zsh";
        font_family = "CaskaydiaCove Nerd Font Mono";
        font_size = 12;
        enable_audio_bell = false;
        tab_bar_edge = "top";
      };
    };

    # VS Code
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        zhuangtongfa.material-theme
        vscodevim.vim
      ];
    };

    # Utilities
    home.file = {
      ".config/zsh/zen".source = pkgs.fetchFromGitHub {
        owner = "cybardev";
        repo = "zen.zsh";
        rev = "2a9f44a19c8fc9c399f2d6a62f4998fffc908145";
      };
      ".local/lib/cutefetch".source = pkgs.fetchFromGitHub {
        owner = "cybardev";
        repo = "cutefetch";
        rev = "e2462c64926f405f3c840efb37803def97c145ed";
      };
      ".local/bin/cutefetch".source = config.lib.file.mkOutOfStoreSymlynk "$HOME/.local/lib/cutefetch/cutefetch";
    };
    home.activation = {
      mkExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run chmod $VERBOSE_ARG +x $HOME/.local/lib/cutefetch/cutefetch
      '';
      installYTGO = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run go $VERBOSE_ARG install github.com/cybardev/ytgo/v3/cmd/ytgo@latest
      '';
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.11";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    unzip
    p7zip
    wget
    gcc
  ];

  # for Zsh completions of system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
