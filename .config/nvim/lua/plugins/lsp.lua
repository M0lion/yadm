return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Management
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Completion
			"saghen/blink.cmp"
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Setup Mason
			require("mason").setup()

			local mason = require("mason-lspconfig")
			mason.setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"rust_analyzer",
				},
				automatic_installation = true,
			})

			-- LSP keybindings
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
			vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

			-- LSP-related Telescope keybindings
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ps', builtin.lsp_document_symbols, opts)
			vim.keymap.set('n', '<leader>per', builtin.diagnostics, opts)
			vim.keymap.set('n', '<leader>prr', builtin.lsp_references, opts)

			-- Set up global LSP behavior
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})
		end,
	}
}
