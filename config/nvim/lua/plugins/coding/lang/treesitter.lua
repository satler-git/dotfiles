return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.sand = {
        install_info = {
          url = "https://github.com/satler-git/sand-markup",
          files = { "tree-sitter/src/parser.c" },
          branch = "main",
        },
        filetype = "sand",
      }

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
          "tsx",
          "javascript",
          "css",
          "astro",
          -- haskell
          "haskell",
          "haskell_persistent",
          -- utils
          "json",
          "jsonc",
          "json5",
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
          "sand",
          "ocaml",
          "ocaml_interface",
          "python",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "VeryLazy" },
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
