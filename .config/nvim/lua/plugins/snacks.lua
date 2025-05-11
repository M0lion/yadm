return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			indent = { enabled = true },
			input = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			git = { enabled = true },
			lazygit = { enabled = true },
		},
		config = function()
			vim.keymap.set("n", "<leader>gs", function()
				Snacks.lazygit()
			end)
		end
	}
}
