return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function()
      -- Register the custom `sand` parser every time nvim-treesitter reloads
      -- the parser table (during TSInstall / TSUpdate).
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").sand = {
            install_info = {
              url = "https://github.com/satler-git/sand-markup",
              branch = "main",
              location = "tree-sitter",
              queries = "queries/sand",
            },
            filetype = "sand",
          }
        end,
      })

      -- Make Neovim aware of the `sand` filetype and parser.
      vim.filetype.add({
        extension = { sand = "sand" },
        filename = { ["README.sand"] = "sand" },
      })
      vim.treesitter.language.register("sand", "sand")
    end,
    config = function()
      local parsers = {
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
        "haskell",
        "haskell_persistent",
        "json",
        "json5",
        "kdl",
        "ledger",
        "markdown",
        "markdown_inline",
        "nix",
        "toml",
        "yaml",
        "gitignore",
        "gitcommit",
        "sand",
        "ocaml",
        "ocaml_interface",
        "python",
        "julia",
      }

      local function enable_ts(buf)
        local ok = pcall(vim.treesitter.start, buf)
        if ok then
          vim.bo[buf].indentexpr = [[v:lua.require"nvim-treesitter".indentexpr()]]
        end
      end

      -- Highlight and indent are no longer enabled by nvim-treesitter.configs.
      -- Enable them for every buffer whose filetype has a parser available.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          enable_ts(args.buf)
        end,
      })

      -- Ensure all desired parsers are installed (no-op when already installed).
      require("nvim-treesitter").install(parsers):await(function(err)
        if err then
          return
        end

        -- Apply treesitter to buffers that were loaded before the parsers
        -- became available (e.g. the first buffer at startup).
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            enable_ts(buf)
          end
        end
      end)
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
