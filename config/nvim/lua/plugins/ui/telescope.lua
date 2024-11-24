return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = {
      "Telescope",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
          "stevearc/dressing.nvim",
        },
        opts = {
          default = {
            disable = true, -- disable any unkown pickers (recommended)
            use_cwd = true, -- differentiate scoring for each picker based on cwd
            sorting = "recent", -- sorting: options: 'recent' and 'frecency'
          },
          pickers = { -- allows you to overwrite the default settings for each picker
            man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
              disable = false,
              use_cwd = false,
              sorting = "frecency",
            },
            lsp_workspace_symbols = {
              disable = false,
            },
            ["ghq#ghq"] = {
              disable = false,
              use_cwd = false,
              sorting = "frecency",
            },
            ["ghq#list"] = {
              disable = false,
              use_cwd = false,
              sorting = "frecency",
            },
          },
        },
      },
    },
    keys = {
      { "<Space>fi", "<Cmd>Telescope lsp_workspace_symbols<CR>" },
      { "<Space>fw", "<Cmd>Telescope live_grep<CR>" },
      { "<Space>fl", "<Cmd>Telescope current_buffer_fuzzy_find<CR>" },
      { "<Space>fh", "<Cmd>Telescope help_tags<CR>" },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    keys = {
      { "<Space>ff", "<Cmd>Telescope smart_open<CR>" },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("smart_open")
    end,
  },
  {
    "nvim-telescope/telescope-ghq.nvim",
    keys = {
      { "<Space>fp", "<Cmd>Telescope ghq<CR>" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("ghq")
    end,
  },
}
