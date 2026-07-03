{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
    };
    # DMS は gsettings get org.gnome.desktop.interface icon-theme で
    # システムアイコンテーマを検出する。これが未設定だとトレイアイコンが
    # 解決されず壊れたアイコンになる (input-keyboard-symbolic など)。
    # Reversal-dark は dark background 用の明るいアイコンを提供し、
    # blueman-tray, application-exit, view-refresh なども含む。
    # Inherits=Numix-Circle,Adwaita,hicolor で symbolic アイコンも解決される。
    iconTheme = {
      name = "Reversal-dark";
      package = pkgs.reversal-icon-theme;
    };
    # gtk4.theme = config.gtk.theme;
  };
}
