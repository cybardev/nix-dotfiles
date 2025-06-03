{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    highlight.ExtraWhitespace.bg = "red";
    colorschemes.onedark = {
      enable = true;
      settings.style = "darker";
    };
    globals = {
      mapleader = " ";
      direnv_auto = 1;
      direnv_silent_load = 0;
    };
    keymaps = [
      # swap : and ;
      {
        action = ":";
        key = ";";
        mode = "n";
      }
      {
        action = ";";
        key = ":";
        mode = "n";
      }
      # lsp
      {
        action = "<cmd>LspInfo<CR>";
        key = "<leader>li";
        options.desc = "LSP Info";
      }
      # neotree
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle reveal_force_cwd<cr>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (root dir)";
        };
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (cwd)";
        };
      }
      {
        mode = "n";
        key = "<leader>be";
        action = ":Neotree buffers<CR>";
        options = {
          silent = true;
          desc = "Buffer explorer";
        };
      }
      {
        mode = "n";
        key = "<leader>ge";
        action = ":Neotree git_status<CR>";
        options = {
          silent = true;
          desc = "Git explorer";
        };
      }
      # oil
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>-";
      }
      # telescope
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
      }
    ];
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      swapfile = false;
      undofile = true;
    };
    extraConfigLua = ''
      if vim.lsp.config then
        vim.lsp.config('*', {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
      end
    '';
    plugins = {
      avante = {
        enable = true;
        settings = {
          provider = "ollama";
          behaviour = {
            enable_cursor_planning_mode = true;
          };
          ollama = {
            endpoint = "http://localhost:11434";
            model = "qwen2.5-coder:7b";
          };
          selector = {
            provider = "fzf_lua";
            provider_opts = { };
          };
        };
      };
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          appearance = {
            nerd_font_variant = "normal";
            use_nvim_cmp_as_default = true;
          };
          cmdline = {
            enabled = true;
            keymap = {
              preset = "inherit";
            };
            completion = {
              list.selection.preselect = false;
              menu = {
                auto_show = true;
              };
              ghost_text = {
                enabled = true;
              };
            };
          };
          completion = {
            menu.border = "rounded";
            accept = {
              auto_brackets = {
                enabled = true;
                semantic_token_resolution = {
                  enabled = false;
                };
              };
            };
            documentation = {
              auto_show = true;
              window.border = "rounded";
            };
          };
          sources = {
            default = [
              "lsp"
              "buffer"
              "path"
              "snippets"
              "git"
              "avante_commands"
              "avante_mentions"
              "avante_files"
            ];
            providers = {
              buffer = {
                enabled = true;
                score_offset = 0;
              };
              lsp = {
                name = "LSP";
                enabled = true;
                score_offset = 10;
              };
              git = {
                module = "blink-cmp-git";
                name = "Git";
              };
              avante_commands = {
                name = "avante_commands";
                module = "blink.compat.source";
              };
              avante_mentions = {
                name = "avante_mentions";
                module = "blink.compat.source";
              };
              avante_files = {
                name = "avante_files";
                module = "blink.compat.source";
              };
            };
          };
        };
      };
      blink-cmp-git.enable = true;
      blink-compat.enable = true;
      comment.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];
            markdown = [ "prettier" ];
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            python = [ "black" ];
            yaml = [ "yamlfmt" ];
          };
        };
      };
      lspkind.enable = true;
      lazygit.enable = true;
      fzf-lua.enable = true;
      git-conflict.enable = true;
      lualine.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          jsonls.enable = true;
          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          marksman.enable = true;
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixfmt" ];
          };
          pyright = {
            enable = true;
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic";
                  autoSearchPaths = true;
                  useLibraryCodeForTypes = true;
                  diagnosticMode = "workspace";
                };
              };
            };
          };
          yamlls.enable = true;
        };
      };
      neo-tree = {
        enable = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        closeIfLastWindow = true;
        popupBorderStyle = "rounded";
        buffers = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = true;
          };
        };
        window = {
          width = 40;
          height = 15;
          autoExpandWidth = false;
        };
      };
      none-ls.sources.formatting.black.enable = true;
      oil.enable = true;
      telescope.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<leader>t]]";
          direction = "float";
          float_opts = {
            title_pos = "center";
            border = "rounded";
            height = 32;
            width = 86;
          };
        };
      };
      treesitter = {
        enable = true;
        folding = false;
        settings.indent.enable = true;
      };
      web-devicons.enable = true;
      which-key.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      blink-cmp-avante
    ];
  };
}
