{ pkgs, inputs, ... }:
{
  home.file.".cargo/config.toml".source = pkgs.writers.writeTOML "cargo-config.toml" {
    target.x86_64-unknown-linux-gnu = {
      linker = "clang";
      rustflags = [
        "-C"
        "link-arg=-fuse-ld=mold"
      ];
    };
  };

  home.packages = with pkgs; [
    clang
    mold-wrapped
    (fenix.combine [
      fenix.stable.toolchain
      fenix.targets.wasm32-unknown-unknown.stable.rust-std
    ])

    inputs.cargo-compete.packages.${system}.cargo-compete
    cargo-nextest
  ];
}
