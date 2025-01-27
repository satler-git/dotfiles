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
          "vimdoc",
          "typst",
          "dockerfile",
          "editorconfig",
          "typescript",
          "javascript",
          "css",
          "astro",
          -- haskell
          "haskell",
          "haskell_persistent",
          -- utils
          "json",
          "jsonc",
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
    "Wansmer/treesj",
    keys = { "<Space>m" }, -- m -> toggle
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      notify = true,
    },
  },
}
