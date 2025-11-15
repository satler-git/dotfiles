return {
  {
    "kevinhwang91/nvim-ufo",
    event = { "FileType" },
    dependencies = {
      "kevinhwang91/promise-async",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local ufo = require("ufo")

      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)
      vim.keymap.set("n", "zm", ufo.closeFoldsWith)

      ufo.setup({})
    end,
  },
}
