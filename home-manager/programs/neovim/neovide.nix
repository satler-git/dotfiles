{ pkgs, ... }:
{
  home.packages = [
    (pkgs.neovide.overrideAttrs (_: {
      doCheck = false;
    }))
  ];
}
