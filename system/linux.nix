{
  pkgs,
  userTZ,
  userLocale,
  userNickname,
  userName,
  ...
}:
{
  imports = [
    ./common.nix
  ];

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
    kanata # keyboard remapper

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
}
