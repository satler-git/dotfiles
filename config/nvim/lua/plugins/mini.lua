return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.trailspace").setup({})
    end,
    event = "VimEnter",
  },
}
