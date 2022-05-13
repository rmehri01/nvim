require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")
