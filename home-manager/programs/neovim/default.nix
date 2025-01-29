{ pkgs, ... }:
let
  testing-language-server-src =
    (pkgs.callPackages ../../../_sources/generated.nix { }).testing-language-server;

  testing-language-server = pkgs.rustPlatform.buildRustPackage {
    pname = "testing-language-server";
    version = "0.0.15";

    doCheck = false; # ファイルを削除しようとして権限でテストが失敗する

    src = testing-language-server-src.src;
    cargoLock.lockFile = testing-language-server-src.cargoLock."Cargo.lock".lockFile;
  };

  testing-ls-adapter = pkgs.rustPlatform.buildRustPackage {
    pname = "testing-ls-adapter";
    version = "0.0.9";

    src = testing-language-server-src.src;
    cargoLock.lockFile = testing-language-server-src.cargoLock."Cargo.lock".lockFile;

    doCheck = false; # ファイルを削除しようとして権限でテストが失敗する

    cargoBuildFlags = [ "--manifest-path=crates/adapter/Cargo.toml" ];
  };

  dicts_lua = ''
    -- SKKELETON's JISYO
    vim.fn['skkeleton#config']({
      globalDictionaries = {'${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L'},
      eggLikeNewline = true,
    })
  '';

  denops_server_addr = "127.0.0.1";
  denops_server_port = 32123;
in
{
  imports = [
    ./neovide.nix
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    # vimAlias = true;
    extraPackages =
      with pkgs;
      [
        gcc # for Tree sitter
        nodejs
        deno
        python39
        sqlite
        sqlite.dev

        haskellPackages.fast-tags

        # Lang-servers
        efm-langserver

        buf
        elixir-ls
        ghc # needed by haskell-language-server
        haskell-language-server
        lua-language-server
        rust-analyzer-nightly

        tinymist # For typst

        nil
        taplo # Toml
        vscode-langservers-extracted
        yaml-language-server

        astro-language-server
        biome
        typescript-language-server

        # Formatter
        nixfmt-rfc-style
        rustfmt
        stylish-haskell
        stylua

        # DAP
        haskellPackages.ghci-dap
        haskellPackages.haskell-debug-adapter

        imagemagick
        ueberzugpp

        cargo-nextest # neotest-rust
      ]
      ++ [
        testing-language-server
        testing-ls-adapter
      ];
    extraLuaPackages = ps: [
      ps.jsregexp
    ];
  };

  my.services.denopsSharedServer = {
    enable = true;
    port = denops_server_port;
    extraDenoArgs = [
      # "--unstable-ffi" # For ddt-ui-shell
    ];
    hostName = denops_server_addr;
  };

  xdg.configFile = {
    "nvim/" = {
      target = "nvim";
      source = ../../../config/nvim;
      recursive = true;
    };
    "nvim-ime/" = {
      target = "nvim-ime";
      source = ../../../config/nvim-ime;
      recursive = true;
    };
    "nvim-ime/lua/dicts.lua" = {
      text = dicts_lua;
    };
    "nvim/lua/dicts.lua" = {
      text = dicts_lua;
    };
    "nvim/lua/extra.lua" = {
      text = ''
        vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
        vim.g.cpptools_path = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7"
        vim.g.denops_server_addr = "${denops_server_addr}:${toString denops_server_port}"
        vim.g.astro_tsdk = "${pkgs.astro-language-server}/lib/astro-language-server/node_modules/typescript/lib"
      '';
    };
    "efm-langserver/config.yaml" = {
      text = pkgs.lib.generators.toYAML { } (
        import ./efm-config.nix {
          inherit pkgs;
          lib = pkgs.lib;
        }
      );
    };
  };
}
