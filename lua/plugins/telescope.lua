require("telescope").setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      width = 0.9,
      height = 0.9,
      horizontal = { preview_width = 0.5 },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")
