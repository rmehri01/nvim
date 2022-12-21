-- Don't continue comments on new line
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  command = "setlocal formatoptions-=cro",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Enable spellchecking in markdown, text, and gitcommit files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NeogitCommitMessage", "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Run PackerCompile when plugins are updated
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "**/*.lua" }
)
