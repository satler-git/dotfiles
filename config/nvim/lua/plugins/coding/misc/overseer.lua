return {
  {
    "stevearc/overseer.nvim",
    lazy = true,
    cmd = { "OverseerRun" },
    keys = {
      { "<Space>tr", "<Cmd>OverseerRun<CR>" },
      { "<Space>tb", "<Cmd>OverseerBuild<CR>" },
    },
    opts = {},
  },
}
