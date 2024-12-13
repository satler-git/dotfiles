return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "j-hui/fidget.nvim",
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
          vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
        end,
      },
      {
        "nvimdev/lspsaga.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
        keys = {
          { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Show the hover document" },
          { "ga", "<Cmd>Lspsaga code_action<CR>", desc = "Show and Run code actions" },
          { "gn", "<Cmd>Lspsaga rename<CR>", desc = "Rename identifier" },
          { "gd", "<Cmd>Lspsaga peek_definition<CR>" },
          { "gr", "<Cmd>Lspsaga finder" },

          { "ge", "<Cmd>Lspsaga show_line_diagnostics<CR>" },
          { "[e", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
          { "]e", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
          { "<Space><C-o>", "<Cmd>Lspsaga outline<CR>" },
        },
        opts = {
          symbol_in_winbar = {
            enable = true,
          },
          lightbulb = {
            enable = false,
          },
        },
      },
    },
  },
  config = function()
    require("config.ls")
  end,
}
