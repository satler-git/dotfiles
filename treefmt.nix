{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    stylua.enable = true;
  };
}
