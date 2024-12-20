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
    opts = { -- TODO: add keymaps
      adapters = {
        require("neotest-plenary"),
        require("neotest-rust"),
        require("neotest-haskell"),
      },
    },
    -- stylua: ignore
    keys = {
      { "<Space>ta", function() require("neotest").run.run(".") end },
      { "<Space>tt", function() require("neotest").run.run(vim.fn.expand("%")) end },
      -- { "<Space>tt", function() require("neotest").run.run() end },
      { "<Space>ts", function() require("neotest").run.stop() end },
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
