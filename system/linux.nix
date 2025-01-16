{ lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>

    ./common.nix

    ../packages/linux.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gcc
    kanata # keyboard remapper

    # XFCE panel plugins
    xfce.xfce4-verve-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-weather-plugin
  ];

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
