{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      autoupdate = false;
      theme = "aura";
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
        lmstudio = {
          npm = "@ai-sdk/openai-compatible";
          name = "LM Studio";
          options = {
            baseURL = "http://localhost:1234/v1";
          };
          models = {
            "granite-4.0-h-tiny-mlx" = {
              name = "IBM Granite Tiny";
              limit = {
                context = 131072;
                output = 32768;
              };
            };
          };
        };
      };
      model = "github-copilot/gpt-5-mini";
      # model = "lmstudio/granite-4.0-h-tiny-mlx";
      # small_model = "lmstudio/granite-4.0-h-tiny-mlx";
      mcp = {
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
