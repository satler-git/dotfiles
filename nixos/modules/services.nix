{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        gnome.enable = true;
      };
      xkb = {
        layout = "jp";
        variant = "";
      };
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    ollama = {
      enable = true;
      acceleration = "cuda";
      openFirewall = true;
      loadModels = [
        "gemma"
        "llama3.2"
        "phi3:14b"
        "qwen2.5-coder"
        "qwen2.5:14b"
      ];
    };
    open-webui = {
      enable = true;
      openFirewall = true;
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
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
