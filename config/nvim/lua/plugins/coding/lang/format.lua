return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- keep-sorted start
          astro = { "biome" },
          dart = { "dart_format" },
          haskell = { "stylish-haskell" },
          javascript = { "biome" },
          json = { "biome" },
          lua = { "stylua" },
          nix = { "nixfmt" },
          rust = { "rustfmt", lsp_format = "fallback" },
          toml = { "taplo" },
          tsx = { "biome" },
          typescript = { "biome" },
          typst = { "typstyle" },
          julia = { "runic" },
          -- keep-sorted end
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
