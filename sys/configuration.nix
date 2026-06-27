# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.userConfig) flakePath;
  hostName = config.userConfig.hostname;
  userName = config.userConfig.username;
  userNickname = config.userConfig.nickname;
  userLocale = config.userConfig.locale;
  userTZ = config.userConfig.timezone;
  userId = 1000;
  # sshKeyFile = "id_ed25519";
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x390
    ./hardware-configuration.nix
    ./nixcommand.nix
    ../mod/userconfig.nix
  ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    operation = "boot";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    flake = "path:${flakePath}";
  };
  nix = {
    optimise = {
      automatic = false; # FIXME: https://github.com/NixOS/nix/issues/7273
      dates = [ "weekly" ];
    };
  };
  nixpkgs.config.allowUnfreePredicate = import ./unfree.nix { inherit lib; };

  # enable zsh for the system
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    uid = userId;
    shell = pkgs.zsh;
    isNormalUser = true;
    description = userNickname;
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
    ];
  };

  # # needed for gitui: https://github.com/gitui-org/gitui/issues/495#issuecomment-2771242566
  # programs.ssh.startAgent = true;
  # # add ssh key on login
  # systemd.user.services.ssh-add-key = {
  #   wantedBy = ["default.target"];
  #   after = ["ssh-agent.service"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStartPre = "${pkgs.coreutils-full}/bin/sleep 1";
  #     ExecStart = [
  #       "${pkgs.openssh}/bin/ssh-add ${config.users.users.${userName}.home}/.ssh/${sshKeyFile}"
  #     ];
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #   };
  # };

  # Set your time zone.
  time.timeZone = userTZ;

  # Select internationalisation properties.
  i18n.defaultLocale = userLocale;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      xarchiver-wrapped = pkgs.symlinkJoin {
        name = "xarchiver-wrapped";
        paths = [ pkgs.xarchiver ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          rm "$out/bin/xarchiver"
          makeWrapper "${pkgs.xarchiver}/bin/xarchiver" "$out/bin/xarchiver" \
            --prefix PATH : ${
              pkgs.lib.makeBinPath (
                with pkgs;
                [
                  gnutar
                  gzip
                  bzip2
                  xz
                  zstd
                  zip
                  unzip
                  p7zip
                  unar
                ]
              )
            }
        '';
      };
    in
    with pkgs;
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      gcc
      xarchiver-wrapped

      # default theme
      whitesur-icon-theme
      qogir-icon-theme
      qogir-theme

      # XFCE panel plugins
      xfce4-verve-plugin
      xfce4-systemload-plugin
      xfce4-whiskermenu-plugin
      xfce4-weather-plugin
      xfce4-clipman-plugin
    ];

  programs.thunar.plugins = with pkgs; [
    thunar-media-tags-plugin
    thunar-archive-plugin
    thunar-shares-plugin
    thunar-vcs-plugin
    thunar-volman
  ];

  services = {
    # desktopManager.plasma6.enable = true;
    # displayManager.plasma-login-manager.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the XFCE Desktop Environment.
      displayManager = {
        lightdm = {
          enable = true;
          greeters = import ./gtk.nix { inherit pkgs; };
        };
        importedVariables = [
          "GDK_SCALE"
          "GDK_DPI_SCALE"
          "QT_AUTO_SCREEN_SCALE_FACTOR"
        ];
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
  };

  # HiDPI display config
  environment = {
    variables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
      _JAVA_OPTIONS = "-sun.java2d.uiScale=2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = 42;
    };
    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/${toString userId}/ssh-agent";
    };
  };
  services.xserver = {
    dpi = 120;
    upscaleDefaultCursor = true;
  };

  # for Zsh completions of system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the Tailscale service and the firewall
  services.tailscale.enable = true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # https://wiki.nixos.org/wiki/Tailscale#DNS
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "true";
      DNSSEC = "false";
      FallbackDNS = [
        "194.242.2.4#base.dns.mullvad.net"
        "194.242.2.6#family.dns.mullvad.net"
        "194.242.2.3#adblock.dns.mullvad.net"
        "2a07:e340::4#base.dns.mullvad.net"
        "2a07:e340::6#family.dns.mullvad.net"
        "2a07:e340::3#adblock.dns.mullvad.net"
      ];
    };
  };

  # Enable and configure kanata
  services.kanata = {
    enable = true;
    keyboards = {
      "kbd" = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
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
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.hostName = hostName;
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  hardware.bluetooth.enable = true;

  # Fingerprint Scanner
  services.fprintd.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
