-- General ---------------------------------------------------------------------

-- Lower timeoutlen
vim.opt.timeoutlen = 500

-- Decrease update time
vim.o.updatetime = 250

-- Editing ---------------------------------------------------------------------

-- Make line numbers default
vim.wo.number = true

-- Use relative line numbers
vim.opt.relativenumber = true

-- Allow neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse mode
vim.o.mouse = "a"

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep cursor closer to the center
vim.o.scrolloff = 10

-- UI Improvements -------------------------------------------------------------

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.cursorline = true -- highlight the current line

-- Use color column
vim.opt.colorcolumn = "100"

-- Set highlight on search
vim.o.hlsearch = true

-- Enable smart indenting
vim.opt.smartindent = true
vim.o.breakindent = true

-- Always use signcolumn
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Don't need to show mode since it's in the statusline
vim.o.showmode = false

-- Performance -----------------------------------------------------------------

-- Disable unused built-ins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Use filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
