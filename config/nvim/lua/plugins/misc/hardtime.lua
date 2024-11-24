return {
  {
    "m4xshen/hardtime.nvim",
    enable = false,
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    cmd = { "Hardtime" },
    opts = {
      disabled_filetypes = { "qf", "lazy", "oil", "nofile", "trouble", "aerial" },
    },
  },
}
