return {
	"lambdalisue/vim-kensaku-search",
	dependencies = {
		{
			"lambdalisue/vim-kensaku",
			dependencies = {
				"vim-denops/denops.vim",
			},
		},
	},
	cmd = {
		"KensakuActive", -- HACK:
	}, -- 検索
	config = function()
		vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { noremap = true, silent = true })
	end,
	enabled = false,
}
