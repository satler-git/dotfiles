return {
  {
    "echasnovski/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup({})
    end,
    event = "VimEnter",
  },
}
