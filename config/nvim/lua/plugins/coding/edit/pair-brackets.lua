return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
      require("insx.preset.standard").setup()
    end,
  },
}
