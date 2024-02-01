return {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "comment",
    "gitcommit",
    "gitignore",
    "go",
    "haskell",
    "help",
    "json",
    "lua",
    "python",
    "regex",
    "rust",
    "make",
    "markdown",
    "markdown_inline",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-up>",
      node_incremental = "<M-up>",
      scope_incremental = "<nop>",
      node_decremental = "<M-down>",
    },
  },
  matchup = {
    enable = true,
  },
  autopairs = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["aS"] = "@statement.outer",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>Ta"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>TA"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },
  },
}
