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
local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local schemastore = require("schemastore")

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    vim.lsp.inlay_hint.enable(true)
  end,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      cargo = {
        buildScripts = { -- For build.rs
          enable = true,
        },
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closureCaptureHints = {
          enable = true,
        },
      },
    },
  },
})
lspconfig.yamlls.setup({
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = { enable = false },
      schemas = schemastore.yaml.schemas(),
    },
  },
})
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
})
configs.testing_ls = {
  default_config = {
    cmd = { "testing-language-server" },
    filetypes = { "rust" },
    root_dir = util.root_pattern(".git", "Cargo.toml"),
    init_options = {
      enable = true,
      fileTypes = { "rust" },
      adapterCommand = {
        rust = {
          {
            path = "testing-ls-adapter",
            extra_arg = { "--test-kind=cargo-nextest" },
            include = { "/**/src/**/*.rs" },
            exclude = { "/**/target/**" },
          },
        },
      },
      enableWorkspaceDiagnostics = true,
      trace = {
        server = "verbose",
      },
    },
  },
  docs = {
    description = [[
      https://github.com/kbwo/testing-language-server

      Language Server for real-time testing.
    ]],
  },
}

lspconfig.efm.setup({
  settings = {
    rootMarkers = { ".git/", ".jj/" },
  },
  filetypes = { "rust", "yaml" },
})

-- lspconfig.testing_ls.setup({})
vim.lsp.config("dartls", {
  capabilities = capabilities,
})
vim.lsp.enable("dartls")

lspconfig.buf_ls.setup({})
lspconfig.elixirls.setup({
  capabilities = capabilities,
  cmd = { "elixir-ls" },
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
})
lspconfig.nil_ls.setup({
  capabilities = capabilities,
})
lspconfig.taplo.setup({
  capabilities = capabilities,
})
lspconfig.tinymist.setup({
  capabilities = capabilities,
})
lspconfig.astro.setup({
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = vim.g.astro_tsdk,
    },
  },
})
lspconfig.biome.setup({
  capabilities = capabilities,
})
lspconfig.ts_ls.setup({
  capabilities = capabilities,
})
lspconfig.vtsls.setup({
  capabilities = capabilities,
})
lspconfig.typos_lsp.setup({
  capabilities = capabilities,
})
vim.lsp.enable("pest_ls")

configs.sandls = {
  default_config = {
    cmd = { "sand", "lsp" },
    filetypes = { "sand" },
    root_dir = util.root_pattern(".git"),
    init_options = {},
  },
}
vim.lsp.config("sandls", {
  capabilities = capabilities,
})
lspconfig.sandls.setup({})
