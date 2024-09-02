{ pkgs, ... }:
# TODO: 正しく構造化できていない
let
  neovim = import ./packages/neovim.nix;
  git = import ./packages/git.nix;
in
{
  home.packages = [
    neovim
    git
  ];
}
