{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    defaultEditor = true;
    settings = {
      theme = "kanagawa-dragon";
      editor = {
        auto-format = true;
        line-number = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        ":" = "collapse_selection";
        ";" = "command_mode";
        "Meta-f" = ":format";
      };
    };
    languages = {
      language-server = {
        pyrefly = {
          command = "pyrefly";
          args = [ "lsp" ];
        };
        tinymist = {
          config = {
            exportPdf = "onSave";
            outputPath = "$root/_preview/$name";
            formatterMode = "typstyle";
          };
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
  };
}
