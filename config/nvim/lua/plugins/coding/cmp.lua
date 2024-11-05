return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",

      "onsails/lspkind.nvim",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(), --Ctrl+pで補完欄を一つ上に移動
          ["<C-n>"] = cmp.mapping.select_next_item(), --Ctrl+nで補完欄を一つ下に移動
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), --Ctrl+yで補完を選択確定

          ["<CR>"] = cmp.mapping(function(fallback) -- 以下LuaSnip
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = require("lspkind").cmp_format({}),
        },
        sources = cmp.config.sources({ -- 優先
          { name = "emoji" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "skkeleton" },
          { name = "spell" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "petertriho/cmp-git",
    dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
    ft = { "gitcommit", "octo", "gitrebase", "jj" },
    opts = {
      filetypes = { "gitcommit", "octo", "gitrebase", "jj" },
      git = {
        commits = {
          limit = 0,
        },
      },
    },
    init = function()
      table.insert(require("cmp").get_config().sources, { name = "git" })
    end,
  },
}
