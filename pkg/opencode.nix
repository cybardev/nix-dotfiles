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
            "qwen/qwen3-4b-thinking-2507" = {
              name = "Qwen3 2507";
              limit = {
                context = 262144;
                output = 65536;
              };
            };
          };
        };
      };
      # model = "github-copilot/gpt-5-mini";
      model = "lmstudio/qwen/qwen3-4b-thinking-2507";
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
