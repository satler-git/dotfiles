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
      };
    };
    portal = {
      enable = true;
      configPackages = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland # ここではHyprland上ではxdg-desktop-portal-hyprlandのシェアピッカーを使うという設定とその実装をそれぞれ使っている
        # xdg-desktop-portal
        # firefox # これでもできるけど上のほうがbetter(普通のUnixっぽい)
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal
      ];
      xdgOpenUsePortal = true;
    };
  };
}
