{ pkgs, ...}:
let

in {
  home.packages =
    with pkgs;
    [
      gh
      ghq

      eza
      ripgrep

      gcc
    ];
}
