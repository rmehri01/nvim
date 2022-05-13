require("telescope").setup({
  defaults = {
    layout_config = {
      width = 0.9,
      height = 0.9,
      horizontal = { preview_width = 0.5 },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")
