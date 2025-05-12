-- This file returns all plugin specs from individual modules
return {
	{ import = "plugins.telescope" },
	{ import = "plugins.lualine" },
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },
	{ import = "plugins.formatting" },
	{ import = "plugins.snacks" },
	{ import = "plugins.mini" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "catppuccin/nvim",            name = "catppuccin", priority = 1000 },
}
