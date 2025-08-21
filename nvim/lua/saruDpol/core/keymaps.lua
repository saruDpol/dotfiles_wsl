-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Terminal mode exit
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Delete a word backwords
keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap.set("n", "te", ":tabedit<Return>", opts)
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", "tabprev<Return>", opts)

-- remapping s for the netrw and other stuff
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		-- Remap Shift+s to cycle sorting in netrw
		vim.keymap.set("n", "s", "<Nop>", { buffer = true })
		vim.keymap.set("n", "S", "<Plug>NetrwSortBy", { buffer = true, silent = true })
	end,
})

-- remap for s to nothing..
vim.keymap.set("n", "s", "<Nop>", { buffer = false })

vim.keymap.set("n", "<leader>aa", function()
	require("alpha").start()
end, { desc = "Open Alpha Dashboard" })

-- Split Window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move Window
keymap.set("n", "<M-h>", "<C-w>h")
keymap.set("n", "<M-k>", "<C-w>k")
keymap.set("n", "<M-j>", "<C-w>j")
keymap.set("n", "<M-l>", "<C-w>l")

-- Resize Window
keymap.set("n", "<M-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<M-Right>", ":vertical resize +2<CR>")
keymap.set("n", "<M-Down>", ":resize +2<CR>")
keymap.set("n", "<M-Up>", ":resize -2<CR>")

-- Diagnostics
vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Explorer
keymap.set("n", "<leader><leader>", vim.cmd.Ex)

-- Moving around
vim.o.scrolloff = 8
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Half-page down and center" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true, silent = true, desc = "Page up and center" })

-- Clipboard keymaps
keymap.set({ "n", "v" }, "<leader>y", '"+y', opts) -- Yank to system clipboard
keymap.set("n", "<leader>Y", '"+Y', opts)

keymap.set({ "n", "v" }, "<leader>p", '"+p', opts) -- Paste from system clipboard
keymap.set("n", "<leader>P", '"+P', opts)

keymap.set({ "n", "v" }, "<leader>d", '"_d', opts) -- Delete without copying

keymap.set("v", "p", '"_dP', opts) -- Replace without copying

-- visual block remap
vim.keymap.set("n", "<leader>v", "<C-q>", { noremap = true, silent = true })
