return {
  {
    "L3MON4D3/LuaSnip", -- nvim-cmpからロードされる
    version = "v2.*",
    lazy = true,
    -- build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/luasnippets/" } })
    end,
  },
}
