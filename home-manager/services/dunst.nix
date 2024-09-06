{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme.package = pkgs.reversal-icon-theme;
    iconTheme.name = "reversal-icon-theme-black";
  };
}
