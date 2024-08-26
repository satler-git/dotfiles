return {
	{
		"uga-rosa/cmp-skkeleton",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		lazy = true,
	},
	{
		"vim-skk/skkeleton",
		dependencies = {
			"vim-denops/denops.vim",
			"uga-rosa/cmp-skkeleton",
		},
		keys = {
			{ "<C-j>", "<Plug>(skkeleton-enable)" },
			{ "<C-j>", "<Plug>(skkeleton-enable)", mode = "c" },
			{ "<C-j>", "<Plug>(skkeleton-enable)", mode = "t" },
		},
		config = function()
			require("cmp").register_source("skkeleton", { name = "skkeleton" })
			vim.fn["skkeleton#config"]({
				globalDictionaries = {
					"~/.skk/SKK-JISYO.L",
					"~/.skk/SKK-JISYO.lisp",
					"~/.skk/SKK-JISYO.assoc",
					"~/.skk/SKK-JISYO.edict",
					"~/.skk/SKK-JISYO.propernoun",
				},
				eggLikeNewline = true,
			})
		end,
		lazy = true,
		enabled = false,
	},
}
