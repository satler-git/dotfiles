return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    -- lazy = false,
    ft = { "haskell", "lhaskell", "cabal", "cabalproject", "tidal" },
    config = function()
      local ht = require("haskell-tools")
      vim.keymap.set("n", "K", "ht.hoogle.hoogle_singature")
    end,
  },
}
