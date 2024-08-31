{ pkgs, ...};

let
  git = import ./packages/git.nix;
  neovim = import ./packages/neovim.nix;
in {
  home.packages =
    with pkgs;
    [
      git
      gh
      ghq

      eza
      ripgrep

      neovim
    ]
}
