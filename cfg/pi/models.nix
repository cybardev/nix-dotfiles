{
  providers = {
    omlx = {
      baseUrl = "http://localhost:1234/v1";
      api = "openai-completions";
      apiKey = "placeholder";
      models = [
        {
          id = "tongrow/MLX-Qwopus3.5-9B-Coder-oQ4-fp16-mtp";
          name = "Clod";
          input = [ "text" ];
          contextWindow = 262144;
          maxTokens = 65536;
        }
      ];
    };
  };
}
