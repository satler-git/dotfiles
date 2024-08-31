{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
in
{
  imports = [ packages ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
