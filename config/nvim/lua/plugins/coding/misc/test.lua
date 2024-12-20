return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      "rouge8/neotest-rust",
      "MrcJkb/neotest-haskell",
    },
    opts = function(_)
      return {
        adapters = {
          require("neotest-rust"),
          require("neotest-haskell"),
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<Space>ta", function() require("neotest").run.run(".") end },
      { "<Space>tt", function() require("neotest").run.run(vim.fn.expand("%")) end },
      -- { "<Space>tt", function() require("neotest").run.run() end },
      { "<Space>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end },
      { "<Space>to", function() require("neotest").output_panel.toggle() end },
      { "<Space>ts", function() require("neotest").summary.toggle() end },
    },
    cmd = { "Neotest" },
  },
  {
    "rouge8/neotest-rust",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "MrcJkb/neotest-haskell",
  },
}
