{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "kanagawa-dragon";
      editor = {
        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 5000;
          };
        };
        auto-format = true;
        line-number = "relative";
        lsp.display-messages = true;
        soft-wrap.enable = true;
        file-picker.hidden = false;
        cursor-shape.insert = "bar";
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
      };
      keys.normal = {
        ":" = "collapse_selection";
        ";" = "command_mode";
        "Meta-f" = ":format";
        "Meta-s" = ":write";
        "Meta-x" = ":write-quit";
        "Meta-z" = ":quit";
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
        pgtools = {
          command = "postgrestools";
          args = [ "lsp-proxy" ];
        };
      };
      language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
        }
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
            command = "ruff";
            args = [ "-" ];
          };
        }
        {
          name = "typescript";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
        {
          name = "sql";
          language-servers = [
            "pgtools"
          ];
          formatter = {
            command = "pg_format";
            args = [
              # "--wrap-limit"
              # "80"
              "--spaces"
              "2"
              "--keyword-case"
              "1"
              "--function-case"
              "1"
              "--type-case"
              "1"
              "--format-type"
              "--comma-break"
              "--keep-newline"
              "--no-extra-line"
              "--no-space-function"
            ];
          };
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
      ];
    };
  };
}
