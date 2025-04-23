-- Enable line numbers
vim.opt.nu = true               -- Show absolute line numbers
vim.opt.relativenumber = true   -- Show relative line numbers for easier navigation

-- Tab and indentation settings
vim.opt.tabstop = 2             -- A tab is displayed as 2 spaces wide
vim.opt.softtabstop = 0         -- When 0, disables soft tabs (uses tabstop value)
vim.opt.shiftwidth = 2          -- Number of spaces for each indentation level
vim.opt.expandtab = false       -- Don't convert tabs to spaces (use actual tab characters)

vim.opt.smartindent = true      -- Automatically indent new lines in a smart way

vim.opt.wrap = false            -- Don't wrap long lines

-- File management settings
vim.opt.swapfile = false        -- Don't create swap files
vim.opt.backup = false          -- Don't create backup files

-- Set up persistent undo (allows undo even after closing and reopening files)
local home = os.getenv("HOME")
if(home == nil) then
    home = os.getenv("UserProfile")  -- Fallback for Windows
end
vim.opt.undodir = home .. "/.vim/undodir"  -- Directory to store undo files
vim.opt.undofile = true                   -- Enable persistent undo

-- Search settings
vim.opt.hlsearch = false        -- Don't highlight all search matches
vim.opt.incsearch = true        -- Show matches as you type

-- UI settings
vim.opt.termguicolors = true    -- Enable true color support

vim.opt.scrolloff = 8           -- Keep at least 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"      -- Always show the sign column (where diagnostics appear)
vim.opt.isfname:append("@-@")   -- Add @ to the list of characters considered part of a filename

vim.opt.updatetime = 50         -- Reduce update time for more responsive UI (default is 4000ms)

-- Color scheme
vim.cmd.colorscheme "catppuccin" -- Set the colorscheme to Catppuccin
