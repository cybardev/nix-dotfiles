{ inputs, ... }:
{
  imports = [ inputs.cypkgs.modules.pi-coding-agent ];

  home.file = {
    ".pi/agent/extensions/pi-permission-system/config.json".source = ../cfg/pi/permissions.json;
  };

  programs.pi-coding-agent = {
    enable = true;
    instructions = ../cfg/pi/AGENTS.md;
    settings = {
      defaultProvider = "openrouter";
      defaultModel = "deepseek/deepseek-v4-flash";
      defaultThinkingLevel = "low";
      hideThinkingBlock = true;
      packages = [
        "@gotgenes/pi-permission-system"
        "@juicesharp/rpiv-ask-user-question"
        "@juicesharp/rpiv-todo"
        "pi-subagents"
        "pi-intercom"
        "pi-web-access"
        "context-mode"
      ];
      collapseChangelog = true;
      enableInstallTelemetry = false;
      enableAnalytics = false;
    };
    models.providers = {
      cylm = {
        baseUrl = "https://lm.polydactyl-little.ts.net/v1";
        api = "openai-completions";
        apiKey = "placeholder";
        models = [
          {
            name = "Clod";
            id = "tongrow/MLX-Qwopus3.5-9B-Coder-oQ4-fp16-mtp";
            input = [
              "text"
              "image"
            ];
            contextWindow = 262144;
            maxTokens = 65536;
          }
        ];
      };
      openrouter = {
        baseUrl = "https://openrouter.ai/api/v1";
        api = "openai-completions";
        apiKey = "$OPENROUTER_API_KEY";
        models = [
          {
            name = "SeekR";
            id = "deepseek/deepseek-v4-flash";
            input = [
              "text"
              "image"
            ];
            contextWindow = 1048576;
            maxTokens = 524288;
          }
        ];
      };
    };
  };
}
