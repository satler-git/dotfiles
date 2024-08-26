return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VimEnter",
		opts = {
			ident = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
		enabled = false,
	},
	{
		"andersevenrud/nvim_context_vt",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VimEnter",
		config = true,
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VimEnter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = {
							"textsubjects-container-inner",
							desc = "Select inside containers (classes, functions, etc.)",
						},
					},
				},
			})
		end,
	},
}
