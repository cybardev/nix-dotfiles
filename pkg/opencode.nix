{
  lib,
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = false;
    enableMcpIntegration = true;
    tui.theme = "everforest";
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      autoupdate = false;
      instructions = [
        "CONTRIBUTING.md"
        "docs/guidelines.md"
        ".cursor/rules/*.md"
      ];
      disabled_providers = [
        # "github-copilot"
        "opencode"
        "ollama"
      ];
      provider = {
        openrouter = {
          models = {
            "deepseek/deepseek-v4-flash" = { };
          };
        };
        omlx = {
          npm = "@ai-sdk/openai-compatible";
          name = "oMLX";
          options = {
            baseURL = "http://localhost:1234/v1";
          };
          models = {
            "tongrow/MLX-Qwopus3.5-9B-Coder-oQ4-fp16-mtp" = {
              name = "Clod";
              limit = {
                context = 262144;
                output = 65536;
              };
            };
          };
        };
      };
      # model = "github-copilot/gpt-5-mini";
      model = "openrouter/deepseek/deepseek-v4-flash";
      # model = "omlx/tongrow/MLX-Qwopus3.5-9B-Coder-oQ4-fp16-mtp";
      mcp = {
        github = {
          enabled = false;
          type = "local";
          command = [
            (lib.getExe' pkgs.github-mcp-server "github-mcp-server")
            "stdio"
          ];
        };
        context7 = {
          enabled = true;
          type = "local";
          command = [
            "bun"
            "x"
            "@upstash/context7-mcp"
          ];
        };
      };
      command = {
        hi = {
          template = "echo hi";
          description = "Say hi. Confirms readiness.";
          agent = "plan";
        };
        ctx = {
          template = "$ARGUMENTS. use context7";
          description = "Prompt with context7 MCP server.";
        };
      };
    };
  };
}
