return {
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip', version = 'v2.*' },
		version = "1.*",
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			signature = { enabled = true },

			snippets = { preset = 'luasnip' },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono"
			},

			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		opts = {
			history = true,
			updateevents = "TextChanged,TextChangedI",
		},
		config = function(_, opts)
			require("luasnip").config.setup(opts)
			
			-- Keybindings for snippet jumping
			local luasnip = require("luasnip")
			vim.keymap.set({"i", "s"}, "<Tab>", function()
				if luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					return "<Tab>"
				end
			end, {silent = true, expr = true})
			
			vim.keymap.set({"i", "s"}, "<S-Tab>", function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					return "<S-Tab>"
				end
			end, {silent = true, expr = true})
			
			-- Exit snippet mode with Ctrl+E
			vim.keymap.set({"i", "s"}, "<C-e>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				else
					luasnip.unlink_current()
				end
			end, {silent = true})
		end,
	}
}
