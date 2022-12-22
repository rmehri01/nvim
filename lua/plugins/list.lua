return {
  -- Editing -------------------------------------------------------------------

  -- Smart commenting
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Faster navigation
  { "ggandor/lightspeed.nvim" },
  { "tpope/vim-repeat" },

  -- Edit surroundings
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
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
      })
    end,
  },

  -- Manage terminal windows
  {
    "akinsho/toggleterm.nvim",
    keys = "<C-t>",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<C-t>",
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },

  -- File explorer tree
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = "kyazdani42/nvim-web-devicons",
    tag = "nightly",
    config = function()
      require("plugins.nvim-tree")
    end,
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
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
  },

  -- Reopen files at last edit position
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  },

  -- Automatically set indentation style
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
  },

  -- Tree Sitter ---------------------------------------------------------------

  -- Fast incremental parsing for highlighting, editing, and navigating code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("plugins.treesitter")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/playground" },

  -- Show context of the buffer contents
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end,
  },

  -- Outline window
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = function()
      require("aerial").setup()
    end,
  },

  -- LSP -----------------------------------------------------------------------

  -- Collection of configurations for built-in LSP client
  {
    "neovim/nvim-lspconfig",
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
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" },
    config = function()
      require("plugins.rust-tools")
    end,
  },

  -- Allows non-LSP sources to use the LSP client
  {
    "jose-elias-alvarez/null-ls.nvim",
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
    cmd = "TroubleToggle",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  -- Auto format on save
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup()
    end,
  },

  -- Autocompletion ------------------------------------------------------------

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-path" },
  {
    "petertriho/cmp-git",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup({
        filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup({
        popup = {
          border = "rounded",
        },
      })
    end,
  },

  { "L3MON4D3/LuaSnip" }, -- Snippets plugin
  { "rafamadriz/friendly-snippets" },

  -- Git -----------------------------------------------------------------------

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
        },
      })
    end,
  },
  { "sindrets/diffview.nvim" },

  -- Add git related info in the signs columns and popups
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_formatter_opts = {
          relative_time = true,
        },
      })
    end,
  },

  -- UI Improvements -----------------------------------------------------------

  -- Select things (files, grep results, open buffers...)
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Theme
  {
    dir = "~/.config/nvim/onenord.nvim",
    config = function()
      require("onenord").setup({
        styles = {
          keywords = "italic",
        },
      })
    end,
  },

  -- Fancier statusline and bufferline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
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
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    event = "BufWinEnter",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          always_show_bufferline = false,
          offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
        },
      })
    end,
  },
  { "kyazdani42/nvim-web-devicons" }, -- More icons

  -- Better quickfix list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  },

  -- Peek lines of a buffer
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  -- Improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("noice").setup({
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
      })
    end,
  },

  -- Scrollbar with diagnostics
  {
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup()
    end,
  },

  -- Flash cursor when jumping
  {
    "edluffy/specs.nvim",
    config = function()
      require("specs").setup({
        popup = {
          inc_ms = 7, -- time increments used for fade/resize effects
          width = 30,
          winhl = "PmenuSel",
        },
      })
    end,
  },

  -- Fancy dashboard
  {
    "goolord/alpha-nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.alpha")
    end,
  },

  -- Highlight todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
  },

  -- Manage and display key bindings
  {
    "folke/which-key.nvim",
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
