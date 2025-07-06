{ pkgs, ... }:
let
  theme = "catppuccin-frappe";
in
{
  stylix = {
    homeManagerIntegration.followSystem = false;
    homeManagerIntegration.autoImport = true;

    enable = true;
    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  };
}
