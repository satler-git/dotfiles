return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = {
      "rust",
      "lua",
      "haskell",
      "nix",
      "toml",
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          haskell = { "stylish-haskell" },
          nix = { "nixfmt" },
          toml = { "taplo" },
          json = { "deno_fmt" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
