return {
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    keys = {
      { "<Space>a", "<Cmd>AerialToggle! right<CR>" },
      {
        "<Space>fa",
        function()
          require("telescope").load_extension("aerial")
          require("telescope").extensions.aerial.aerial()
        end,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
