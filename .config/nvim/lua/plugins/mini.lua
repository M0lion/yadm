return {
	{
		"echasnovski/mini.files",
		version = "*",
		keys = {
			{
				"<leader>pv",
				function()
					local file_path = vim.api.nvim_buf_get_name(0)

					MiniFiles.open(file_path)
					MiniFiles.reveal_cwd()
				end,
				desc = "Open file explorer"
			},
		},
		opts = {
			options = { use_as_default_explorer = true }
		},
	},
	{
		"echasnovski/mini.ai",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter",
		},
		version = "*",
		config = function()
			local spec_treesitter = require('mini.ai').gen_spec.treesitter
			require("mini.ai").setup({
				custom_textobjects = {
					F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
				},
			})
		end
	},
}
