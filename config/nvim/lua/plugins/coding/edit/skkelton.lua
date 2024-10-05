return {
  { "delphinus/skkeleton_indicator.nvim", opts = {} },
  {
    "vim-skk/skkeleton",
    event = "VeryLazy",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
      "rinx/cmp-skkeleton",
    },
    keys = {
      { "<C-j>", "<Plug>(skkeleton-toggle)", mode = { "i", "c" } },
    },
    config = function()
      require("dicts")
    end,
  },
}
