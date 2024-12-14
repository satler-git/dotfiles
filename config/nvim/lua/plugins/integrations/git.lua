return {
  {
    "lewis6991/gitsigns.nvim",
    version = "*",
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  },
  {
    "lambdalisue/vim-gin",
    event = "VeryLazy",
    cmd = {
      "Gin",
      "GinBuffer",
      "GinBranch",
      "GinBrowse",
      "GinCd",
      "GinLcd",
      "GinTcd",
      "GinChaperon",
      "GinDiff",
      "GinEdit",
      "GinLog",
      "GinPatch",
      "GinStatus",
    },
    dependencies = {
      "vim-denops/denops.vim",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<Space>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    opts = {},
  },
}
