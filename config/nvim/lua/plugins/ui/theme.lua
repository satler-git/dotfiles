return {
  {
    "daltonmenezes/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-soft-dark-soft-text]])
    end,
    enabled = false,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({})
      vim.cmd([[colorscheme kanagawa]])
    end,
    enabled = true,
  },
}
