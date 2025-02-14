{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (inputs.cargo-compete.packages.${pkgs.system}) cargo-compete;
in
{
  home.file.".cargo/config.toml".source = pkgs.writers.writeTOML "cargo-config.toml" {
    target.x86_64-unknown-linux-gnu = {
      linker = "clang";
      rustflags = [
        "-C"
        "link-arg=-fuse-ld=mold"
      ];
    };

    build.rustc-wrapper = lib.getExe pkgs.sccache;
  };

  home.sessionVariables.SCCACHE_CACHE_SIZE = "50G";

  home.packages = with pkgs; [
    # faster compilling
    clang
    mold-wrapped
    sccache

    # standard rust compiler(rustc and cargo and tools(rustfmt, cargo-clippy, ...))
    (fenix.combine [
      fenix.stable.toolchain

      fenix.minimal.toolchain
      fenix.latest.rustc-codegen-cranelift-preview

      fenix.targets.wasm32-unknown-unknown.stable.rust-std
    ])

    # cargo subcomannds
    # keep-sorted start
    cargo-audit
    cargo-compete
    cargo-nextest
    cargo-tauri
    cargo-expand
    # keep-sorted end
  ];
}
