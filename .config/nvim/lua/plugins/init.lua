-- This file returns all plugin specs from individual modules
return {
	{ import = "plugins.telescope" },
	{ import = "plugins.lualine" },
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },
	{ import = "plugins.formatting" },
	{ import = "plugins.snacks" },
	{ "catppuccin/nvim",            name = "catppuccin",                                                   priority = 1000 },
	{ "tpope/vim-fugitive",         config = function() vim.keymap.set("n", "<leader>gs", vim.cmd.Git) end }
}
