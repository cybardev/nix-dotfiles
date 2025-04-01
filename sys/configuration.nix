# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  config,
  pkgs,
  hostName,
  userConfig,
  extraArgs,
  ...
}:
let
  userName = userConfig.username;
  userNickname = userConfig.nickname;
  userLocale = userConfig.locale;
  userTZ = userConfig.timezone;
  linuxFlake = if extraArgs.surfaceKernel then "linux-surface" else "linux";
in
{
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    operation = "boot";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    flake = "path:${extraArgs.home}${builtins.substring 1 (-1) userConfig.nixos}#${linuxFlake}";
  };
  nix = {
    package = lib.mkDefault pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = userNickname;
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
    ];
  };

  # Set your time zone.
  time.timeZone = userTZ;

  # Select internationalisation properties.
  i18n.defaultLocale = userLocale;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gcc

    # default theme
    whitesur-icon-theme
    qogir-icon-theme
    qogir-theme

    # XFCE panel plugins
    xfce.xfce4-verve-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-weather-plugin
  ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the XFCE Desktop Environment.
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Qogir-Dark";
          package = pkgs.qogir-theme;
        };
        cursorTheme = {
          name = "Qogir-manjaro-dark";
          package = pkgs.qogir-icon-theme;
          size = 64;
        };
        iconTheme = {
          name = "WhiteSur-dark";
          package = pkgs.whitesur-icon-theme;
        };
      };
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        # noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # HiDPI display config
  services.xserver = {
    dpi = 148;
    upscaleDefaultCursor = true;
  };
  environment.variables = {
    # GDK_SCALE = "2.2";
    # GDK_DPI_SCALE = "0.4";
    # _JAVA_OPTIONS = "-sun.java2d.uiScale=2.2";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XCURSOR_SIZE = 64;
  };

  # for Zsh completions of system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable and configure kanata
  services.kanata = {
    enable = true;
    keyboards = {
      "kbd" = {
        config = ''
          (defsrc)
          (deflayer default)
          (defoverrides
            (esc) (caps)
            (caps) (esc)
            (lsft spc) (bspc)
            (rsft spc) (del)
          )
        '';
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

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
  hardware.uinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
