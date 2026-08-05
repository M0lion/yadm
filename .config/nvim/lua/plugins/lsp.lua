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
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Set up global LSP behavior before servers are enabled
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"rust_analyzer",
					"kotlin_language_server",
					"astro_language_server",
				},
				automatic_enable = true,
			})

			-- Astro LSP needs the JS-based TypeScript API (tsserverlibrary.js), which
			-- typescript@7 (native) no longer ships — neither in projects nor in Mason's
			-- astro package, whose vendored copy is also 7.x. Borrow the 5.x copy from
			-- Mason's typescript-language-server package when the project has no usable one.
			-- Must come after mason-lspconfig setup(), which registers its own (broken)
			-- before_init for astro and would otherwise override this one.
			vim.lsp.config("astro", {
				before_init = function(_, config)
					local function usable(dir)
						return vim.fn.filereadable(dir .. "/tsserverlibrary.js") == 1
							or vim.fn.filereadable(dir .. "/typescript.js") == 1
					end
					local local_tsdk = (config.root_dir or vim.fn.getcwd()) .. "/node_modules/typescript/lib"
					local mason_tsdk = vim.fn.expand(
						"$MASON/packages/typescript-language-server/node_modules/typescript/lib"
					)
					config.init_options = config.init_options or {}
					config.init_options.typescript = config.init_options.typescript or {}
					config.init_options.typescript.tsdk = usable(local_tsdk) and local_tsdk or mason_tsdk
				end,
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
			vim.keymap.set('n', '<leader>pi', builtin.lsp_implementations)
		end,
	}
}
