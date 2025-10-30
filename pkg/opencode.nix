{
  inputs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    inputs.cypkgs.modules.opencode
  ];

  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    config = {
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
            "deepcogito-cogito-v1-preview-llama-3b" = {
              name = "Cogito Mini";
              limit = {
                context = 131072;
                output = 32768;
              };
            };
          };
        };
      };
      # model = "github-copilot/gpt-5-mini";
      model = "lmstudio/deepcogito-cogito-v1-preview-llama-3b";
      # small_model = "lmstudio/deepcogito-cogito-v1-preview-llama-3b";
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
