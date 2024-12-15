{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage = { ... }: {
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
  };
}

