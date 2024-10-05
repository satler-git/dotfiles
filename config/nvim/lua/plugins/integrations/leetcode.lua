local leet_arg = "leetcode.nvim"
return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "Leet",
  },
  lazy = leet_arg ~= vim.fn.argv()[1],
  opts = {
    lang = "rust",
    arg = leet_arg,
  },
}
