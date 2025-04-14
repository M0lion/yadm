return {
	{
		{
			"ravitemer/mcphub.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			build = "npm install -g mcp-hub@latest",
			config = function()
				require("mcphub").setup({
					port = 5999,
					config = vim.fn.expand("~/.config/mcphub/servers.json"),
				})
			end,
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- for example
			provider = "claude",
			-- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				return hub:get_active_servers_prompt()
			end,
			-- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
			{ "nvim-lua/plenary.nvim" },
			-- Test with blink.cmp
			{
				"saghen/blink.cmp",
				lazy = false,
				version = "*",
				opts = {
					keymap = {
						preset = "enter",
						["<S-Tab>"] = { "select_prev", "fallback" },
						["<Tab>"] = { "select_next", "fallback" },
					},
					cmdline = { sources = { "cmdline" } },
					sources = {
						default = { "lsp", "path", "buffer", "codecompanion" },
					},
				},
			},
			-- Test with nvim-cmp
			-- { "hrsh7th/nvim-cmp" },
		},
		opts = {
			--Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "cmd:op read op://Employee/Anthropic/credential --no-newline",
						},
					})
				end,
			},
			strategies = {
				--NOTE: Change the adapter as required
				chat = {
					adapter = "anthropic",
					tools = {
						["mcp"] = {
							callback = function()
								return require("mcphub.extensions.codecompanion")
							end,
							description = "Call tools and resources from the MCP Servers",
							opts = {
								requires_approval = true,
							},
						},
					},
				},
				inline = { adapter = "claude" },
			},
			opts = {
				log_level = "DEBUG",
			},
		},
	},
--	{
--		"yetone/avante.nvim",
--		event = "VeryLazy",
--		version = false, -- Never set this value to "*"! Never!
--		opts = {
--			provider = "claude",
--		},
--		build = "make",
--		dependencies = {
--			"nvim-treesitter/nvim-treesitter",
--			"stevearc/dressing.nvim",
--			"nvim-lua/plenary.nvim",
--			"MunifTanjim/nui.nvim",
--			"nvim-telescope/telescope.nvim",
--			"ibhagwan/fzf-lua",
--			{
--				-- Make sure to set this up properly if you have lazy=true
--				'MeanderingProgrammer/render-markdown.nvim',
--				opts = {
--					file_types = { "markdown", "Avante" },
--				},
--				ft = { "markdown", "Avante" },
--			},
--		},
--		config = function ()
--			require("avante").setup({
--				-- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
--				system_prompt = function()
--					local hub = require("mcphub").get_hub_instance()
--					return hub:get_active_servers_prompt()
--				end,
--				-- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
--				custom_tools = function()
--					return {
--						require("mcphub.extensions.avante").mcp_tool(),
--					}
--				end,
--			})
--		end,
--	},
--	{
--		"ravitemer/mcphub.nvim",
--		dependencies = {
--			"nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
--		},
--		-- Removed lazy loading to ensure hub loads at startup
--		-- cmd = "MCPHub",  -- lazy load by default
--		build = "npm install -g mcp-hub@latest",  -- Installs required mcp-hub npm module
--		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
--		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
--		config = function()
--			require("mcphub").setup({
--				log_level = "debug", -- Enable debug logging to help troubleshoot
--				auto_start = true, -- Ensure the hub starts automatically
--				extensions = {
--					avante = {
--						make_slash_commands = true, -- make /slash commands from MCP server prompts
--					}
--				}
--			})
--		end,
--	},
}
