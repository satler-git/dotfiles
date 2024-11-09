return {
  {
    "daltonmenezes/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-soft-dark-soft-text]])
    end,
    enabled = true,
  },
}
