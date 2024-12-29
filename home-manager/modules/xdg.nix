{ pkgs, ... }:
{
  xdg = {
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      configPackages = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland # ここではHyprland上ではxdg-desktop-portal-hyprlandのシェアピッカーを使うという設定とその実装をそれぞれ使っている
        # xdg-desktop-portal
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
