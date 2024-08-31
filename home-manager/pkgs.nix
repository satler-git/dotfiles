{ pkgs, ...}:
let

in {
  home.packages =
    with pkgs;
    [
      gh
      ghq
      lazygit

      eza
      ripgrep

      gcc

      fzf

      spotify
    ];
}
