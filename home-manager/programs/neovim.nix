{ pkgs, ... }:
let
  harper_ls = pkgs.rustPlatform.buildRustPackage {
    pname = "harper-ls";
    version = "0.11.0";

    src = pkgs.fetchFromGitHub {
      owner = "elijah-potter";
      repo = "harper";
      rev = "3c06fc8b763835a16885c104b69e461f8870bb1e";
      sha256 = "sha256-sDXwsv5g32SXfZbv8IX/r3hj1iOPOaWbCJxEe/oxZ8Y=";
    };

    cargoHash = "sha256-9HSXL6llRNolH4tSvYKqCFcaTwpuyr+h3wzjzz7QLZM=";
  };
  dicts_lua = ''
    -- SKKELETON's JISYO
    vim.api.nvim_exec(
      [[
        call skkeleton#config({
          \   'globalDictionaries': ['${pkgs.skkDictionaries.l}/share/SKK-JISYO.L'],
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
      harper_ls
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
