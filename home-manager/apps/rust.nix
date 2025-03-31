{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (inputs.cargo-compete.packages.${pkgs.system}) cargo-compete;
  cargo-nightly =
    toolchain:
    pkgs.stdenv.mkDerivation {
      pname = "cargo-nightly";
      version = "1.0.0";
      src = null;

      buildInputs = [ toolchain ];
      nativeBuildInputs = [ pkgs.installShellFiles ];

      dontUnpack = true;

      installPhase =
        let
          cargo-nightly = pkgs.writeShellScript "cargo-nightly" ''
            shift

            export PATH="${lib.getBin toolchain}/bin:$PATH"
            exec "${lib.getBin toolchain}/bin/cargo" "$@"
          '';
        in
        ''
          mkdir -p $out/bin
          cp ${cargo-nightly} $out/bin/cargo-nightly

          runHook postInstall
        '';

      postInstall = ''
        cp ${toolchain}/share/zsh/site-functions/_cargo .

        sed -i 's/^#compdef cargo/#compdef cargo-nightly/' _cargo

        installShellCompletion --cmd cargo-nightly \
          --zsh _cargo
      '';
    };

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
    # faster compiling
    clang
    mold-wrapped
    sccache

    # standard rust compiler(rustc and cargo and tools(rustfmt, cargo-clippy, ...))
    (fenix.combine [
      fenix.stable.toolchain

      fenix.latest.rustc-codegen-cranelift-preview

      fenix.targets.wasm32-unknown-unknown.stable.rust-std
    ])

    # cargo subcomannds
    # keep-sorted start
    (cargo-nightly (
      fenix.combine [
        fenix.minimal.toolchain
        (fenix.complete.withComponents [
          "miri"
        ])
      ]
    ))
    cargo-audit
    cargo-compete
    cargo-expand
    cargo-nextest
    cargo-show-asm
    cargo-tauri
    bacon
    # keep-sorted end
  ];
}
