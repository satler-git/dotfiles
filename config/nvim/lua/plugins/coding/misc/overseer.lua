return {
  {
    "stevearc/overseer.nvim",
    lazy = true,
    dependencies = {
      "stevearc/dressing.nvim",
    },
    cmd = { "OverseerRun" },
    opts = {
      strategy = "toggleterm",
    },
  },
}
