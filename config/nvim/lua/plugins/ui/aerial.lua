return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    cmd = {
      "AerialToggle",
      "AerialNext",
      "AerialPrev",
      "AerialGo",
      "AerialInfo",
      "AerialOpen",
      "AerialClose",
      "AerialNavOpen",
      "AerialNavClose",
      "AerialNavToggle",
      "AerialOpenAll",
      "AerialCloseAll",
    },
    keys = { "<leader>a", "<cmd>AerialToggle!<CR>" },
  },
}
