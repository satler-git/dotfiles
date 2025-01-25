{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    stylua.enable = true;
    jsonfmt.enable = true;
    taplo.enable = true;
    yamlfmt.enable = true;
    keep-sorted.enable = true;
  };
}
