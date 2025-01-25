vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    vim.lsp.inlay_hint.enable(true)
  end,
})

local function two_space(pattern)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function(_)
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end,
  })
end

two_space("nix")
two_space("json")
two_space("sh")
