return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "vim-denops/denops.vim" },
	{ "kkharji/sqlite.lua" },
	{
		"stevearc/dressing.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}
