vim.diagnostic.config({
  virtual_text = false,

  virtual_lines = {
    format = function(diagnostic)
      return string.format("%s \n(%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

vim.cmd([[
  highlight DiagnosticUnderlineError gui=undercurl cterm=undercurl
  highlight DiagnosticUnderlineWarn  gui=undercurl cterm=undercurl
  highlight DiagnosticUnderlineInfo  gui=undercurl cterm=undercurl
  highlight DiagnosticUnderlineHint  gui=undercurl cterm=undercurl
]])

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = { -- For nvim-ufo
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "efm",
  "typos_lsp",

  "yamlls",
  "jsonls",
  "taplo",

  "dartls",
  "buf_ls",
  "rust_analyzer",
  "pest_ls",
  "elixirls",
  "lua_ls",
  "nil_ls",
  "tinymist",
  "sandls",
  "ocamllsp",

  "astro",
  "biome",
  "ts_ls",
  "vtsls",

  "ruff",
})
