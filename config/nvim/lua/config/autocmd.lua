vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_args)
    vim.lsp.inlay_hint.enable(true)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function(_)
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
