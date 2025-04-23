return { 
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	tag = "0.1.6",
	config = function()
		require("telescope").setup {
			pickers = {
				git_files = {
					show_untracked = true
				}
			}
		}

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set("n", "<leader>pd", builtin.live_grep, {})
		vim.keymap.set('n', '<C-p>', function()
			local ok = pcall(require('telescope.builtin').git_files)
			if not ok then
				-- If git_files fails (not in a git repo), fallback to find_files
				require('telescope.builtin').find_files()
			end
		end, {})
		require("telescope.health").check()
	end,
}
