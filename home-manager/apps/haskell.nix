{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # keep-sorted start
    cabal-install
    ghc
    stack
    # keep-sorted end
  ];
}
