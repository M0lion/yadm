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
}
