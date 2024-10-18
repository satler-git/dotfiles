{ pkgs, ... }:
let
  harper-src = (pkgs.callPackages ../../_sources/generated.nix { }).harper-ls;
  harper-ls = pkgs.rustPlatform.buildRustPackage {
    pname = "harper-ls";
    version = "0.11.0";

    src = harper-src.src;
    cargoLock.lockFile = harper-src.cargoLock."Cargo.lock".lockFile;
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
    vimAlias = true;
    extraPackages = with pkgs; [
      sqlite
      sqlite.dev
      nodejs
      python39

      haskellPackages.fast-tags

      # Lang-servers
      lua-language-server
      elixir-ls
      nil
      taplo
      yaml-language-server
      harper-ls

      # DAP
      haskellPackages.ghci-dap
      haskellPackages.haskell-debug-adapter
    ];
    extraLuaPackages = ps: [ ps.jsregexp ];
  };

  home.file = {
    ".config/nvim/" = {
      target = ".config/nvim";
      source = ../../config/nvim;
      recursive = true;
    };
    ".config/nvim-ime/" = {
      target = ".config/nvim-ime";
      source = ../../config/nvim-ime;
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
    ".bin/vime.sh" = {
      source = ../../config/bin/vime.sh;
      executable = true;
    };
  };
}
