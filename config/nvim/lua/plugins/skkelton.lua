return {
  { "delphinus/skkeleton_indicator.nvim", opts = {} },
  {
    "vim-skk/skkeleton",
    event = "VeryLazy",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
      "uga-rosa/cmp-skkeleton",
    },
    keys = {
      { "<C-j>", "<Plug>(skkeleton-toggle)", mode = { "i", "c" } },
    },
    config = function()
      require("cmp").register_source("skkeleton", { name = "skkeleton" })
      require("dicts")
    end,
  },
}
