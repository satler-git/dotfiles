return {
  {
    "delphinus/skkeleton_indicator.nvim",
    lazy = false,
    opts = {},
  },
  {
    "vim-skk/skkeleton",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
    },
    keys = {
      { "<C-j>", "<Plug>(skkeleton-toggle)", mode = { "i", "c" } },
    },
    config = function()
      require("dicts")
    end,
  },
}
