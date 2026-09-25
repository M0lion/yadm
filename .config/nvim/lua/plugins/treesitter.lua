return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			for key, obj in pairs({
				f = "@function",
				c = "@class",
				b = "@block",
				a = "@parameter",
				x = "@jsx",
			}) do
				vim.keymap.set({ "x", "o" }, "a" .. key, function()
					select.select_textobject(obj .. ".outer", "textobjects")
				end)
				vim.keymap.set({ "x", "o" }, "i" .. key, function()
					select.select_textobject(obj .. ".inner", "textobjects")
				end)
			end

			local jumps = {
				goto_next_start     = { ["]b"] = "@block.outer", ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]x"] = "@jsx.outer" },
				goto_next_end       = { ["]B"] = "@block.outer", ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]X"] = "@jsx.outer" },
				goto_previous_start = { ["[b"] = "@block.outer", ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[x"] = "@jsx.outer" },
				goto_previous_end   = { ["[B"] = "@block.outer", ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[X"] = "@jsx.outer" },
			}
			for fn, maps in pairs(jumps) do
				for key, obj in pairs(maps) do
					vim.keymap.set({ "n", "x", "o" }, key, function() move[fn](obj, "textobjects") end)
				end
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ':TSUpdate',
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.install({
				"lua", "vim", "vimdoc", "query", "c",
				"markdown", "markdown_inline",
				"typescript", "tsx", "javascript",
				"go", "gomod", "rust", "kotlin", "astro",
				"html", "css", "json", "yaml", "toml",
				"bash", "diff", "gitcommit",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if lang and vim.treesitter.language.add(lang) then
						vim.treesitter.start(ev.buf, lang)
					end
				end,
			})
		end
	},
}
