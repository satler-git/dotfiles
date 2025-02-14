{ config, ... }:
let
  inherit (config.my) openFirewall;
in
{
  services = {
    ollama = {
      enable = true;
      inherit openFirewall;
      loadModels = [
        "llama3.2"
        "qwen2.5-coder:14b"
        "qwen2.5:14b"

        "phi4:14b"
        "gemma2:9b"
        "codestral:22b"

        "deepseek-r1:1.5b"
        "deepseek-r1:7b"
      ];
    };
    open-webui = {
      enable = true;
      inherit openFirewall;
      port = 2222;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        WEBUI_AUTH = "False";
        PYDANTIC_SKIP_VALIDATING_CORE_SCHEMAS = "True";
      };
    };
  };
}
