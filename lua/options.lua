-- General ---------------------------------------------------------------------

-- Lower timeoutlen
vim.opt.timeoutlen = 500

-- Decrease update time
vim.opt.updatetime = 250

-- Editing ---------------------------------------------------------------------

-- Make line numbers default
vim.opt.number = true

-- Use relative line numbers
vim.opt.relativenumber = true

-- Allow neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse mode
vim.opt.mouse = "a"

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep cursor closer to the center
vim.opt.scrolloff = 10

-- UI Improvements -------------------------------------------------------------

-- Force all horizontal splits to go below current window
vim.opt.splitbelow = true

-- Force all vertical splits to go to the right of current window
vim.opt.splitright = true

-- Highlight the current line
vim.opt.cursorline = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Enable smart indenting
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Always use signcolumn
vim.opt.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Don't need to show mode since it's in the statusline
vim.opt.showmode = false

-- Disable echo area
vim.opt.cmdheight = 0

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
