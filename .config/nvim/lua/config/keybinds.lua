-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- J moves line to end of previous line, this bind keeps cursor in the same place instead of moving it
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle of the screen while half paging
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in middle while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Paste from clipboard
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]])

-- Delete without yanking
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Ctrl + s saves
vim.keymap.set({"n", "i", "v"}, "<C-s>", "<Esc>:wr<CR>")
