{ pkgs, ... }:
{
  xdg = {
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";

        "image/bmp" = "org.nomacs.ImageLounge.desktop";
        "image/gif" = "org.nomacs.ImageLounge.desktop";
        "image/jpeg" = "org.nomacs.ImageLounge.desktop";
        "image/png" = "org.nomacs.ImageLounge.desktop";
        "image/webp" = "org.nomacs.ImageLounge.desktop";

        "audio/aac" = "mpv.desktop";
        "audio/midi" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/opus" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "audio/webm" = "mpv.desktop";

        "video/mpeg" = "mpv.desktop";
        "video/mp4" = "mpv.desktop";
        "video/ogg" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
      };
    };
    portal = {
      enable = true;
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        # xdg-desktop-portal-hyprland # ここではHyprland上ではxdg-desktop-portal-hyprlandのシェアピッカーを使うという設定とその実装をそれぞれ使っている
        # xdg-desktop-portal
        # firefox # これでもできるけど上のほうがbetter(普通のUnixっぽい)
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        # xdg-desktop-portal-hyprland
        xdg-desktop-portal
      ];
      xdgOpenUsePortal = true;
    };
  };
}
