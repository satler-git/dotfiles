return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
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

          { "ge", "<Cmd>Lspsaga show_line_diagnostics<CR>" },
          { "[e", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
          { "]e", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
          { "<Leader><C-o>", "<Cmd>Lspsaga outline<CR>" },
        },
        opts = {
          lightbulb = {
            enable = false,
          },
        },
      },
    },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("lspconfig").rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
        },
      },
    })
    require("lspconfig").elixirls.setup({
      capabilities = capabilities,
      cmd = { "elixir-ls" },
    })
    require("lspconfig").lua_ls.setup({})
    require("lspconfig").nil_ls.setup({})
  end,
}
