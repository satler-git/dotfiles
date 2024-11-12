{ pkgs, ... }:
let
  harper-src = (pkgs.callPackages ../../../_sources/generated.nix { }).harper-ls;
  harper-ls = pkgs.rustPlatform.buildRustPackage {
    pname = "harper-ls";
    version = "0.11.0";

    src = harper-src.src;
    cargoLock.lockFile = harper-src.cargoLock."Cargo.lock".lockFile;
  };

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
    vim.api.nvim_exec(
      [[
        call skkeleton#config({
          \   'globalDictionaries': ['${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L'],
          \   'eggLikeNewline': v:true,
          \ })
      ]],
    false
    )
  '';
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    # vimAlias = true;
    extraPackages =
      with pkgs;
      [
        nodejs
        python39
        sqlite
        sqlite.dev

        haskellPackages.fast-tags

        # Lang-servers
        efm-langserver
        elixir-ls
        lua-language-server
        nil
        taplo # Toml
        vscode-langservers-extracted
        yaml-language-server

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
      ]
      ++ [
        harper-ls
        testing-language-server
        testing-ls-adapter
      ];
    extraLuaPackages = ps: [
      ps.jsregexp
      ps.magick
    ];
  };

  home.file = {
    ".config/nvim/" = {
      target = ".config/nvim";
      source = ../../../config/nvim;
      recursive = true;
    };
    ".config/nvim-ime/" = {
      target = ".config/nvim-ime";
      source = ../../../config/nvim-ime;
      recursive = true;
    };
    ".config/nvim-ime/lua/dicts.lua" = {
      text = dicts_lua;
    };
    ".config/nvim/lua/dicts.lua" = {
      text = dicts_lua;
    };
    ".config/nvim/lua/extra.lua" = {
      text = "vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    };
    ".config/efm-langserver/config.yaml" = {
      text = pkgs.lib.generators.toYAML { } (
        import ./efm-config.nix {
          inherit pkgs;
          lib = pkgs.lib;
        }
      );
    };
  };
}
