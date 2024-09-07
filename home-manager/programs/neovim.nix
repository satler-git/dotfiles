{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      sqlite
      sqlite.dev
      nodejs
    ];
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
      text = ''
        -- SKKELETON's JISYO
        vim.api.nvim_exec(
          [[
            call skkeleton#config({
              \   'globalDictionaries': ['${pkgs.skk-dicts}/share/SKK-JISYO.L'],
              \   'eggLikeNewline': v:true,
              \ })
          ]],
        false
        )
      '';
    };
    ".config/nvim/lua/extra.lua" = {
      text = "vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    };
  };
}
