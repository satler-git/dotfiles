return {
	"neovim/nvim-lspconfig",
	event = "VimEnter",
	dependencies = {
		{
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					{
						"williamboman/mason.nvim",
						config = true,
					},
				},
				config = true,
			},
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
			{
				"nvimdev/lspsaga.nvim",
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					"nvim-tree/nvim-web-devicons",
				},
				keys = {
					{ "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Show the hover document" },
					{ "ga", "<Cmd>Lspsaga code_action<CR>", desc = "Show and Run code actions" },
					{ "gn", "<Cmd>Lspsaga rename<CR>", desc = "Rename identifier" },
					{ "gd", "<Cmd>Lspsaga peek_definition<CR>" },

					{ "ge", "<Cmd>Lspsaga show_line_diagnostics<CR>" },
					{ "[e", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
					{ "]e", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
					{ "<Leader><C-o>", "<Cmd>Lspsaga outline<CR>" },
				},
				config = true,
			},
		},
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.

			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
