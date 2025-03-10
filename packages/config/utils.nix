{ pkgs, ... }:
{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    eza = {
      enable = true;
      colors = "auto";
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-last"
        "--sort=extension"
      ];
    };

    bottom = {
      enable = true;
      settings.styles.theme = "nord";
    };

    mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        visualizer
      ];
    };

    cava = {
      enable = true;
      settings = {
        general = {
          bars = 0;
          bar_width = 6;
          bar_spacing = 2;
        };
        color = {
          gradient = 1;
          gradient_count = 2;
          gradient_color_1 = "'#bb7ebb'";
          gradient_color_2 = "'#ffbeff'";
        };
        output.method = "ncurses";
        smoothing.gravity = 42;
      };
    };

    poetry = {
      enable = true;
      settings.virtualenvs.in-project = true;
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "cybardev";
      userEmail = "sheikh@cybar.dev";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";
        pull.rebase = false;
      };
    };

    gitui = {
      enable = true;
      theme = ./gitui-catppuccin.ron;
    };
  };
}
