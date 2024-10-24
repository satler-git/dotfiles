return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = { "LazyFile", "VeryLazy" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ident = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        ensure_installed = {
          "elixir",
          "lua",
          "rust",
          "proto",
          "sql",
          -- haskell
          "haskell",
          "haskell_persistent",
          -- utils
          "json",
          "kdl",
          "ledger",
          "markdown",
          "markdown_inline",
          "nix",
          "toml",
          "yaml",
          -- git
          "gitignore",
          "gitcommit",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    enabled = true,
  },
  {
    "andersevenrud/nvim_context_vt",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    config = true,
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = {
              "textsubjects-container-inner",
              desc = "Select inside containers (classes, functions, etc.)",
            },
          },
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" }, -- m -> toggle, j -> join, s -> split
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
