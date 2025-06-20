return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },

  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",

    "nvim-telescope/telescope.nvim", -- for 2 Lean-specific pickers
  },

  opts = {
    mappings = true,
  },
}
