return {
  {
    "L3MON4D3/LuaSnip", -- nvim-cmpからロードされる
    dependencies = {
      "mrcjkb/haskell-snippets.nvim",
    },
    version = "v2.*",
    lazy = true,
    -- build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnippets/" })

      -- Load Haskell snipetts
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
}
