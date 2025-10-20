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
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {
            "cogito:14b" = {
              name = "Cogito";
            };
            "cogito:3b" = {
              name = "Cogito Mini";
            };
          };
        };
      };
      model = "ollama/cogito:3b";
      small_model = "ollama/cogito:3b";
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
