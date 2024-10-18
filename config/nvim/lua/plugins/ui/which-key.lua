return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Space>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {},
  enabled = false,
}
