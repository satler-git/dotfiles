return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "LspAttach" },

    config = function()
      -- lspkind.lua
      local lspkind = require("lspkind")
      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      table.insert(require("cmp").get_config().sources, { name = "copilot" })
      require("copilot_cmp").setup()
    end,
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false,
  --   opts = {
  --     provider = "copilot",
  --   },
  --   build = "make",
  --   cmd = {
  --     "AvanteAsk",
  --     "AvanteBuild",
  --     "AvanteChat",
  --     "AvanteEdit",
  --     "AvanteFocus",
  --     "AvanteRefresh",
  --     "AvanteSwitchProvider",
  --     "AvanteShowRepoMap",
  --     "AvanteToggle",
  --   },
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --
  --     "nvim-telescope/telescope.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "nvim-tree/nvim-web-devicons",
  --     "zbirenbaum/copilot.lua",
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
