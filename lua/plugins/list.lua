return {
  -- General -------------------------------------------------------------------

  { "nvim-lua/plenary.nvim", lazy = true },

  -- Editing -------------------------------------------------------------------

  -- Smart commenting
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- Faster navigation
  { "ggandor/lightspeed.nvim", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- Edit surroundings
  {
    "kylechui/nvim-surround",
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      enable_check_bracket_line = false,
      fast_wrap = {
        map = "<C-b>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        highlight = "LightspeedShortcut",
        highlight_grey = "LightspeedGreyWash",
      },
    },
  },

  -- Manage terminal windows
  {
    "akinsho/toggleterm.nvim",
    keys = "<C-t>",
    opts = {
      open_mapping = "<C-t>",
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },

  -- File explorer tree
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    tag = "nightly",
    opts = require("plugins.nvim-tree"),
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- Better matching text using tree sitter
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  -- Annotation generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
    },
  },

  -- Reopen files at last edit position
  {
    "ethanholz/nvim-lastplace",
    opts = {},
  },

  -- Automatically set indentation style
  {
    "nmac427/guess-indent.nvim",
    opts = {},
  },

  -- Tree Sitter ---------------------------------------------------------------

  -- Fast incremental parsing for highlighting, editing, and navigating code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = require("plugins.treesitter"),
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPost" },

  -- Show context of the buffer contents
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    opts = {},
  },

  -- Outline window
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    opts = {},
  },

  -- LSP -----------------------------------------------------------------------

  -- Collection of configurations for built-in LSP client
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("plugins.lspconfig")
    end,
  },

  -- Lightbulb on code actions
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = require("nvim-lightbulb").update_lightbulb,
        pattern = "*",
      })
    end,
  },

  -- Extra tools for Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
  },

  -- Allows non-LSP sources to use the LSP client
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.stylua,
        },
      })
    end,
  },

  -- Nicer diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {},
  },

  -- Autocompletion ------------------------------------------------------------

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-path" },
      {
        "petertriho/cmp-git",
        opts = {
          filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
        },
      },
      {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          popup = {
            border = "rounded",
          },
        },
      },
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  -- Snippets plugin
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- Git -----------------------------------------------------------------------

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    opts = {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    },
  },
  { "sindrets/diffview.nvim" },

  -- Add git related info in the signs columns and popups
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      current_line_blame = true,
      current_line_blame_formatter_opts = {
        relative_time = true,
      },
    },
  },

  -- UI Improvements -----------------------------------------------------------

  { "lervag/vimtex" },

  -- Select things (files, grep results, open buffers...)
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Theme
  {
    dir = "~/.config/nvim/onenord.nvim",
    opts = {
      styles = {
        keywords = "italic",
      },
    },
  },

  -- Fancier statusline and bufferline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 1,
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        always_show_bufferline = false,
        offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", lazy = true }, -- More icons

  -- Better quickfix list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {},
  },

  -- Peek lines of a buffer
  {
    "nacro90/numb.nvim",
    opts = {},
  },

  -- Improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        insert_only = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        command_palette = true,
        lsp_doc_border = true,
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      fps = 30,
      stages = "fade_in_slide_out",
      timeout = 500,
      top_down = true,
    },
  },

  -- Scrollbar with diagnostics
  {
    "lewis6991/satellite.nvim",
    opts = {},
  },

  -- Fancy dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("plugins.alpha")
    end,
  },

  -- Highlight todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    opts = {},
  },

  -- Manage and display key bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.which-key")
    end,
  },

  -- Nice diagnostics in virtual text
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("lsp_lines").setup()
    end,
  },
}
