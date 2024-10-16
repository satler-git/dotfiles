return {
  "stevearc/oil.nvim",
  opts = {
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    { "<C-n>", "<Cmd>Oil<CR>" },
  },
  cmd = { "Oil" },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
