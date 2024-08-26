return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-lua/popup.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "vim-denops/denops.vim", lazy = true },
	{
		"stevearc/dressing.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}
