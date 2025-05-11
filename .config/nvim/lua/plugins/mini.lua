return {
	{
		'echasnovski/mini.nvim',
		version = '*',
		config = function()
			require('mini.files').setup({
				options = {
					use_as_default_explorer = true,
				}
			})

			-- Open file explorer
			vim.keymap.set("n", "<leader>pv", function()
				MiniFiles.open()
			end)
		end
	},
}
