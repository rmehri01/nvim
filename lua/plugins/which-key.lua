local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  window = {
    border = "single",
  },
})

local gitsigns = require("gitsigns")
wk.register({
  ["<leader>"] = { "<cmd>Telescope find_files<CR>", "Find file" },
  ["."] = { "<cmd>Telescope file_browser<CR>", "Browse files" },
  n = { "<cmd>ene<cr>", "New file" },
  w = { "<cmd>w!<cr>", "Save" },
  q = { "<cmd>q<cr>", "Quit" },
  x = { "<cmd>bdelete<cr>", "Close buffer" },
  C = { "<cmd>Telescope find_files cwd=~/.config/nvim/<cr>", "Edit config" },
  b = {
    name = "Buffer",
    j = { "<cmd>BufferLinePick<cr>", "Jump to buffer" },
    f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
    s = {
      name = "Sort",
      d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      e = { "<cmd>BufferLineSortByExtension<cr>", "Sort by extension" },
    },
  },
  p = { "<cmd>Lazy<cr>", "Lazy" },
  g = {
    name = "Git",
    j = { gitsigns.next_hunk, "Next hunk" },
    k = { gitsigns.prev_hunk, "Prev hunk" },
    L = { gitsigns.blame_line, "Blame" },
    p = { gitsigns.preview_hunk, "Preview hunk" },
    r = { gitsigns.reset_hunk, "Reset hunk" },
    R = { gitsigns.reset_buffer, "Reset buffer" },
    s = { gitsigns.stage_hunk, "Stage hunk" },
    u = { gitsigns.undo_stage_hunk, "Undo staged hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit for current file" },
    g = { "<cmd>Neogit<cr>", "Neogit" },
    d = {
      name = "Diffview",
      d = { "<cmd>DiffviewOpen<cr>", "Open" },
      c = { "<cmd>DiffviewClose<cr>", "Close" },
      h = { "<cmd>DiffviewFileHistory<cr>", "File history" },
    },
  },
  c = {
    name = "LSP",
    a = { vim.lsp.buf.code_action, "Code action" },
    e = { vim.diagnostic.open_float, "Errors on current line" },
    h = { vim.show_pos, "Highlights" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { vim.diagnostic.goto_next, "Next diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev diagnostic" },
    l = { vim.lsp.codelens.run, "Codelens action" },
    r = { vim.lsp.buf.rename, "Rename" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    p = { "<cmd>Telescope projects<CR>", "Projects" },
    m = { "<cmd>Telescope man_pages<cr>", "Man pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent file" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    ["*"] = { "<cmd>Telescope grep_string<cr>", "String under cursor" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    H = { "<cmd>Telescope highlights<cr>", "Highlights" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Highlights" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Highlights" },
  },
  t = {
    name = "Trouble",
    t = { "<cmd>TroubleToggle<cr>", "Toggle" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
  },
  a = {
    name = "Aerial",
    t = { "<cmd>AerialToggle!<CR>", "Toggle" },
    n = { "<cmd>AerialNext<CR>", "Close" },
    p = { "<cmd>AerialPrev<CR>", "Toggle" },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
    s = { vim.treesitter.inspect_tree, "Show Tree" },
    g = { "<cmd>Neogen<cr>", "Neogen" },
  },
}, {
  prefix = "<leader>",
})
