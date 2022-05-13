-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Switch tabs
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")

-- nvim-tree
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")

-- remove highlight after searching
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")
