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

-- More granular scrolling
vim.opt.mousescroll = "ver:1,hor:6"

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep cursor closer to the center
vim.opt.scrolloff = 10

-- Enable spell checking
vim.opt.spell = true

-- Enable better diffing
vim.opt.diffopt:append({ "linematch:60" })

-- Disable line wrap
vim.opt.wrap = false

-- Better folding using tree-sitter
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- https://github.com/nvim-telescope/telescope.nvim/issues/699#issuecomment-1159637962
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })

-- UI Improvements -------------------------------------------------------------

-- Force all horizontal splits to go below current window
vim.opt.splitbelow = true

-- Force all vertical splits to go to the right of current window
vim.opt.splitright = true

-- Highlight the current line
vim.opt.cursorline = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Use true colors
vim.opt.termguicolors = true

-- Always use signcolumn
vim.opt.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Don't need to show mode since it's in the statusline
vim.opt.showmode = false

-- Stabilize buffer content on window open/close
vim.opt.splitkeep = "screen"

-- Global status line
vim.opt.laststatus = 3

-- Status column

---@return {name:string, text:string, texthl:string}[]
local function get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

function StatusColumn()
  local sign, git_sign
  for _, s in ipairs(get_signs()) do
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end
  local components = {
    sign and ("%#" .. sign.texthl .. "#" .. sign.text .. "%*") or " ",
    [[%=]],
    [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
    git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text .. "%*") or "  ",
  }
  return table.concat(components, "")
end

vim.opt.statuscolumn = [[%!v:lua.StatusColumn()]]
