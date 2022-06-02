require("telescope").setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      width = 0.9,
      height = 0.9,
      horizontal = { preview_width = 0.5 },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    file_ignore_patterns = { ".git" },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hidden = true,
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")
