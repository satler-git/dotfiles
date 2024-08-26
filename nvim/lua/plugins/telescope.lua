return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		cmd = {
			"Telescope",
		},
		keys = {
			{ "<Leader>ff", "<Cmd>Telescope find_files<CR>" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ghq.nvim",
		},
		config = function()
			require("telescope").load_extension("ghq")
		end,
	},
	{ -- あっているはずだがよくわからないことになっているからoff
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = {
			"nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("frecency")
		end,
		enabled = false,
	},
}
