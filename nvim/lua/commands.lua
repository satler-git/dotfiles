-- See https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.inlay_hint for more info
vim.api.nvim_create_user_command("ToggleInlayHint", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})
