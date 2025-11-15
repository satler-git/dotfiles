return {
  {
    "neovim/nvim-lspconfig",
    event = { "FileType" },
    dependencies = {
      {
        "folke/neoconf.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "b0o/schemastore.nvim",
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
            { "gr", "<Cmd>Lspsaga finder<CR>" },

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
  },
  {
    "folke/neoconf.nvim",
    opts = {},
    cmd = { "Neoconf" },
  },
  {
    "bassamsdata/namu.nvim",
    opts = {
      global = {},
      namu_symbols = { -- Specific Module options
        options = {},
      },
    },
    keys = {
      { "<Space>ss", ":Namu symbols<cr>", { desc = "Jump to LSP symbol", silent = true } },
      { "<Space>sw", ":Namu workspace<cr>", { desc = "LSP Symbols - Workspace", silent = true } },
    },
  },
}
