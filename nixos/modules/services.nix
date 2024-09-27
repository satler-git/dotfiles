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
      loadModels = [
        "llama3.2"
        "qwen2.5:14b"
      ];
    };
  };
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
