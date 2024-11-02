return {
  {
    "stevearc/overseer.nvim",
    lazy = true,
    dependencies = {
      "stevearc/dressing.nvim",
    },
    cmd = { "OverseerRun" },
    keys = {
      { "<Space>tr", "<Cmd>OverseerRun<CR>" },
      { "<Space>tb", "<Cmd>OverseerBuild<CR>" },
    },
    opts = {
      strategy = "toggleterm",
    },
  },
}
