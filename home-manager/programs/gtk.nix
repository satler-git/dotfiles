{ config, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
    };
    gtk4.theme = config.gtk.theme;
  };
}
