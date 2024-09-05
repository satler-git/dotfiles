{
  home.file = {
    ".local/wallpapers/paper.png".source = ./paper.png;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "/home/satler/.local/wallpapers/paper.png"
      ];
      wallpaper = [
        ",/home/satler/.local/wallpapers/paper.png"
      ];
    };
  };
}
