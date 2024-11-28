{ pkgs, ... }:
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
      configPackages = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        # xdg-desktop-portal
      ];
      extraPortals = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        # xdg-desktop-portal
      ];
      xdgOpenUsePortal = true;
    };
  };
}
