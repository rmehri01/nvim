-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Add leader shortcuts
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>sf", function()
  require("telescope.builtin").find_files({ previewer = false })
end)
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>st", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>sp", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>so", function()
  require("telescope.builtin").tags({ only_current_buffer = true })
end)
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
