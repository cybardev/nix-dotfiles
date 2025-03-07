{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };

  programs.eza = {
    enable = true;
    colors = "auto";
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-last"
      "--sort=extension"
    ];
  };

  programs.bottom = {
    enable = true;
    settings.styles.theme = "nord";
  };

  programs.cava = {
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

  programs.poetry = {
    enable = true;
    settings.virtualenvs.in-project = true;
  };

  programs.git = {
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

  programs.gitui = {
    enable = true;
    theme = ./gitui-catppuccin.ron;
  };
}
