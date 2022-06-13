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
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  g = {
    name = "Git",
    j = { require("gitsigns").next_hunk, "Next hunk" },
    k = { require("gitsigns").prev_hunk, "Prev hunk" },
    l = { require("gitsigns").blame_line, "Blame" },
    p = { require("gitsigns").preview_hunk, "Preview hunk" },
    r = { require("gitsigns").reset_hunk, "Reset hunk" },
    R = { require("gitsigns").reset_buffer, "Reset buffer" },
    s = { require("gitsigns").stage_hunk, "Stage hunk" },
    u = { require("gitsigns").undo_stage_hunk, "Undo staged hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit for current file" },
    g = { "<cmd>Neogit<cr>", "Neogit" },
    d = {
      name = "Diffview",
      d = { "<cmd>DiffviewOpen<cr>", "Open" },
      c = { "<cmd>DiffviewClose<cr>", "Close" },
    },
  },
  c = {
    name = "LSP",
    a = { vim.lsp.buf.code_action, "Code action" },
    e = { vim.diagnostic.open_float, "Errors on current line" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { vim.diagnostic.goto_next, "Next diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev diagnostic" },
    l = { vim.lsp.codelens.run, "Codelens action" },
    r = { vim.lsp.buf.rename, "Rename" },
    D = { vim.lsp.buf.type_definition, "Type definition" },
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
    s = { "<cmd>Telescope grep_string<cr>", "String under cursor" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    H = { "<cmd>Telescope highlights<cr>", "Highlights" },
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
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    g = { "<cmd>Neogen<cr>", "Neogen" },
  },
}, {
  prefix = "<leader>",
})
