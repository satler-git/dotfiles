-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

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
lspconfig.harper_ls.setup({
  filetypes = { "markdown" },
  settings = {
    ["harper-ls"] = {
      fileDictPath = "~/.harper/",
    },
    linters = {
      spell_check = true,
      spelled_numbers = false,
      an_a = true,
      sentence_capitalization = false,
      unclosed_quotes = true,
      wrong_quotes = false,
      long_sentences = true,
      repeated_words = true,
      spaces = true,
      matcher = true,
      correct_number_suffix = true,
      number_suffix_capitalization = true,
      multiple_sequential_pronouns = true,
      linking_verbs = false,
      avoid_curses = true,
      terminating_conjunctions = true,
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

lspconfig.testing_ls.setup({})
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
