{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        auto-format = true;
        line-number = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        ":" = "collapse_selection";
        ";" = "command_mode";
      };
    };
    languages = {
      language-server = {
        pyrefly = {
          command = lib.getExe pkgs.cy.pyrefly;
          args = [ "lsp" ];
        };
      };
      language = [
        {
          name = "python";
          language-servers = [
            "pyrefly"
            {
              name = "jedi";
              only-features = [
                "rename-symbol"
                "goto-definition"
                "workspace-symbols"
              ];
            }
          ];
          formatter = {
            command = "black";
            args = [ "-" ];
          };
        }
      ];
    };
    themes = {
      edge = ../cfg/helix/edge.toml;
      everforest = ../cfg/helix/everforest.toml;
      rose_pine = ../cfg/helix/rose_pine.toml;
      rose_pine_moon = ../cfg/helix/rose_pine_moon.toml;
      catppuccin_macchiato = ../cfg/helix/catppuccin_macchiato.toml;
    };
  };
}
