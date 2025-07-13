{ pkgs-unstable, ... }:
let
  OLLAMA_MODEL = "qwen2.5-coder:1.5b";
in
{
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;
    extensions = [
      "clojure"
      "csharp"
      "dart"
      "dockerfile"
      "flutter-snippets"
      "git-firefly"
      "lua"
      "mcp-server-context7"
      "nix"
      "pyrefly"
      "terraform"
      "typst"
      "warp-one-dark"
      "zed-docker-compose"
    ];
    userSettings = {
      features = {
        copilot = false;
        edit_prediction_provider = "supermaven";
      };
      telemetry = {
        metrics = false;
      };
      theme = {
        mode = "dark";
        dark = "Warp One Dark";
        light = "One Light";
      };
      buffer_font_family = "CaskaydiaCove Nerd Font";
      buffer_font_size = 13;

      vim_mode = true;
      cursor_blink = false;
      vim = {
        toggle_relative_line_numbers = true;
      };
      terminal = {
        dock = "right";
      };
      calls = {
        mute_on_join = true;
      };

      minimap = {
        show = "auto";
        thumb = "hover";
      };

      prettier = {
        tabWidth = 2;
        singleQuote = false;
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        Python = {
          language_servers = [
            "pyrefly"
            "!pyright"
            "!pylsp"
          ];
        };
        JavaScript = {
          prettier = {
            tabWidth = 4;
          };
        };
      };

      lsp = {
        nixd = {
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };
            diagnostics = {
              ignored = [ "sema-extra-with" ];
            };
          };
        };
        tinymist = {
          settings = {
            exportPdf = "onSave";
            outputPath = "$root/_preview/$name";
          };
        };
      };

      language_models = {
        ollama = {
          api_url = "http://localhost:11434";
          available_models = [
            {
              name = OLLAMA_MODEL;
              supports_tools = true;
              keep_alive = "5m";
            }
          ];
        };
      };

      agent = {
        enabled = true;
        version = "2";
        enable_feedback = false;
        default_model = {
          provider = "ollama";
          model = OLLAMA_MODEL;
        };
        default_profile = "create";
        profiles = {
          create = {
            name = "Create";
            enable_all_context_servers = true;
            tools = {
              copy_path = true;
              create_directory = true;
              delete_path = true;
              diagnostics = true;
              edit_file = true;
              fetch = true;
              list_directory = true;
              move_path = true;
              now = true;
              find_path = true;
              read_file = true;
              open = true;
              grep = true;
              terminal = true;
              thinking = true;
              web_search = true;
            };
          };
        };
      };
    };
  };
}
