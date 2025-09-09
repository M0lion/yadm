return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			-- LSP Management
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",

			-- Completion
			"saghen/blink.cmp"
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"rust_analyzer",

			},
			automatic_installation = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
				automatic_installation = true,
				automatic_enable = true,
			})

			vim.lsp.enable("zls")

			-- LSP keybindings
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
			vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)

			-- LSP-related Telescope keybindings
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ps', builtin.lsp_document_symbols)
			vim.keymap.set('n', '<leader>per', builtin.diagnostics)
			vim.keymap.set('n', '<leader>prr', builtin.lsp_references)

			-- Set up global LSP behavior
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	}
}
