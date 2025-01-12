{ pkgs, inputs, ... }:
{
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        gnome.enable = false;
      };
      xkb = {
        layout = "jp";
        variant = "";
      };
      videoDrivers = [ "vmware" ];
    };
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
      openFirewall = true;
      loadModels = [
        "llama3.2"
        "qwen2.5-coder:14b"
        "qwen2.5:14b"

        "phi3.5:3.8b"
        "phi4:14b"
        "gemma2:9b"
        "codestral:22b"
      ];
    };
    open-webui = {
      enable = true;
      openFirewall = true;
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
    hoogle = {
      enable = true;
      port = 8081;
      packages =
        hp: with hp; [
          lens
        ];
    };
    xremap = {
      userName = "satler";
      serviceMode = "system";
      config = {
        modmap = [
          {
            # CapsLockをCtrlに置換
            name = "CapsLock is dead";
            remap = {
              CapsLock = "Ctrl_L";
            };
          }
        ];
      };
    };
  };
  security.rtkit.enable = true;
}
