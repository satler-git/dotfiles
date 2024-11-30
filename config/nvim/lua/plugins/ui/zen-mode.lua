return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    cmd = { "ZenMode" },
    opts = {
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        alacritty = {
          enabled = true,
          font = "14", -- font size
        },
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {},
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
}
