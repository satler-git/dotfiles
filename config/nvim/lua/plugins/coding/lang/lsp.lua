return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
      {
        "nvimdev/lspsaga.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
        },
        keys = {
          { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Show the hover document" },
          { "ga", "<Cmd>Lspsaga code_action<CR>", desc = "Show and Run code actions" },
          { "gn", "<Cmd>Lspsaga rename<CR>", desc = "Rename identifier" },
          { "gd", "<Cmd>Lspsaga peek_definition<CR>" },

          { "ge", "<Cmd>Lspsaga show_line_diagnostics<CR>" },
          { "[e", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
          { "]e", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
          { "<Space><C-o>", "<Cmd>Lspsaga outline<CR>" },
        },
        opts = {
          lightbulb = {
            enable = false,
          },
        },
      },
    },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
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
    lspconfig.elixirls.setup({
      capabilities = capabilities,
      cmd = { "elixir-ls" },
    })
    lspconfig.lua_ls.setup({})
    lspconfig.nil_ls.setup({})
    lspconfig.taplo.setup({})
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemaStore = { enable = true },
          -- schemas = {
          --   ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          --   ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/compose.*",
          --   ["https://taskfile.dev/schema.json"] = "Taskfile.y*",
          --   ["https://json.schemastore.org/buf.json"] = "buf.y*",
          --   ["https://json.schemastore.org/buf.gen.json"] = "buf.gen.*",
          -- },
        },
      },
    })
    -- lspconfig.remark_ls.setup({
    --   settings = {
    --     remark = {
    --       requireConfig = true,
    --     },
    --   },
    -- })
    -- nixpkgsに見当たらない?
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
    lspconfig.bufls.setup({})
  end,
}
