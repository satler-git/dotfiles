{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (inputs.cargo-compete.packages.${pkgs.stdenv.hostPlatform.system}) cargo-compete;

  # sccache の置き換え。pkgs.kache は通常の nixpkgs 入力に含まれるため、
  # nixpkgs の更新にそのまま追従する。
  kache = pkgs.kache;

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

    build.rustc-wrapper = lib.getExe kache;
  };

  # kache のユーザー設定。`kache init` は ~/.cargo/config.toml や
  # シェルの rc、systemd unit を直接書き換えるので使わず、同等の内容を
  # home-manager から置く。
  xdg.configFile."kache/config.toml".source = (pkgs.formats.toml { }).generate "kache-config.toml" {
    cache = {
      # btrfs なのでリストアは reflink になり、実ディスクはほぼ増えない。
      # sccache で 50G 使っていた頃と同じ上限。
      local_max_size = "200GiB";
    };
  };

  # 常駐デーモン。ビルド間でパイプライン・GC・プリフェッチ・
  # 同一キーのビルド共有を維持する。未起動でもビルド時に自動起動するが、
  # ログイン時から動かしておく。
  systemd.user.services.kache = {
    Unit = {
      Description = "kache build cache daemon";
      After = [ "default.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe kache} daemon run";
      Restart = "on-failure";
      RestartSec = "5s";
      Environment = [ "KACHE_LOG=kache=info" ];
      NoNewPrivileges = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.packages = with pkgs; [
    # faster compiling
    clang
    mold
    kache

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
    bacon
    cargo-audit
    cargo-compete
    cargo-expand
    cargo-nextest
    cargo-show-asm
    cargo-tauri
    # keep-sorted end
  ];
}
