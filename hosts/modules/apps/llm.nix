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
        "gemma3:12b-it-q4_K_M"
        "qwq:32b"
        "qwen3:14b"
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
