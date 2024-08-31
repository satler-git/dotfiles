{ pkgs, ...};
{
  home.packages =
  with pkgs;
  [
    git
    gh
    ghq

    eza
    ripgrep
  ]
}
