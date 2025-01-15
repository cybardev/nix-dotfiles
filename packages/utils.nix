{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage =
    { ... }:
    {
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

      # Cava
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
    };
}
