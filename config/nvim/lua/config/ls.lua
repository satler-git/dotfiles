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

vim.lsp.enable("rust_analyzer")

vim.lsp.enable("yamlls")
vim.lsp.enable("jsonls")
vim.lsp.enable("efm")

vim.lsp.enable("dartls")

vim.lsp.enable("buf_ls")

vim.lsp.config("elixirls", {
  cmd = { "elixir-ls" },
})
vim.lsp.enable("elixirls")

vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("taplo")
vim.lsp.enable("tinymist")

vim.lsp.enable("astro")

vim.lsp.enable("biome")
vim.lsp.enable("ts_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("typos_lsp")
vim.lsp.enable("pest_ls")

vim.lsp.enable("sandls")

vim.lsp.enable("ocamllsp")
