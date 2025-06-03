{ pkgs, ... }:
let
  OLLAMA_MODEL = "qwen2.5-coder:1.5b";
in
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "lua"
      "nix"
      "pyrefly"
      "warp-one-dark"
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
      # cy.pyrefly # FIXME: https://github.com/zed-extensions/pyrefly/issues/1
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

      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "ollama";
          model = OLLAMA_MODEL;
        };
      };
    };
  };
}
