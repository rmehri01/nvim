vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_git_hl = 1

require("nvim-tree").setup({
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "│ ",
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  git = {
    ignore = false,
  },
})
