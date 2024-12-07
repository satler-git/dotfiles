local ft = { "haskell", "lhaskell", "cabal", "cabalproject", "tidal" }

return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    -- lazy = false,
    ft = ft,
    config = function()
      local ht = require("haskell-tools")

      vim.keymap.set("n", "K", function()
        ht.hoogle.hoogle_signature()
      end)
    end,
  },
  {
    "mrcjkb/haskell-snippets.nvim",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    ft = ft,
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
}
