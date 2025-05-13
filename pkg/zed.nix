{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "pylsp"
      "warp-one-dark"
    ];
    extraPackages = with pkgs; [
      nixd
      alejandra
      python3Packages.python-lsp-server
    ];
    userSettings = {
      features = {
        copilot = false;
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

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };

      lsp = {
        nixd = {
          settings = {
            formatting = {
              command = ["alejandra"];
            };
            diagnostics = {
              ignored = ["sema-extra-with"];
            };
          };
        };
      };
    };
  };
}
