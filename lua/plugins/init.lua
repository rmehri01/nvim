-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Set up other plugins
require("packer").startup(function(use)
  -- General -------------------------------------------------------------------
  use("wbthomason/packer.nvim") -- Package manager
  use("lewis6991/impatient.nvim") -- Improve startup time

  -- Editing -------------------------------------------------------------------

  -- Smart commenting
  use({
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  })

  -- Faster navigation
  use("ggandor/lightspeed.nvim")
  use("tpope/vim-repeat")

  -- Edit surroundings
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  })

  use({
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
  })

  -- Manage terminal windows
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<C-t>",
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  })

  -- File explorer tree
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    requires = "kyazdani42/nvim-web-devicons",
    tag = "nightly",
    config = function()
      require("plugins.nvim-tree")
    end,
  })

  -- Project management
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  })

  -- Better matching text using tree sitter
  use({
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  })

  -- Annotation generator
  use({
    "danymat/neogen",
    cmd = "Neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
  })

  -- Reopen files at last edit position
  use({
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  })

  -- Automatically set indentation style
  use({
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
  })

  -- Tree Sitter ---------------------------------------------------------------

  -- Fast incremental parsing for highlighting, editing, and navigating code
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("nvim-treesitter/playground")

  -- Show context of the buffer contents
  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  })

  -- Outline window
  use({
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = function()
      require("aerial").setup()
    end,
  })

  -- LSP -----------------------------------------------------------------------

  -- Collection of configurations for built-in LSP client
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
  })

  -- Lightbulb on code actions
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = require("nvim-lightbulb").update_lightbulb,
        pattern = "*",
      })
    end,
  })

  -- Extra tools for Rust
  use({
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" },
    config = function()
      require("plugins.rust-tools")
    end,
  })

  -- Allows non-LSP sources to use the LSP client
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.stylua,
        },
      })
    end,
  })

  -- Nicer diagnostics list
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  })

  -- Auto format on save
  use({
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup()
    end,
  })

  -- Autocompletion ------------------------------------------------------------

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-path")
  use({
    "petertriho/cmp-git",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup({
        filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
      })
    end,
  })
  use({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup({
        popup = {
          border = "rounded",
        },
      })
    end,
  })

  use("L3MON4D3/LuaSnip") -- Snippets plugin
  use("rafamadriz/friendly-snippets")

  -- Git -----------------------------------------------------------------------

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
        },
      })
    end,
  })
  use("sindrets/diffview.nvim")

  -- Add git related info in the signs columns and popups
  use({
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_formatter_opts = {
          relative_time = true,
        },
      })
    end,
  })

  -- UI Improvements -----------------------------------------------------------

  -- Select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-file-browser.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.telescope")
    end,
  })

  -- Theme
  use({
    "~/.config/nvim/onenord.nvim",
    config = function()
      require("onenord").setup({
        styles = {
          keywords = "italic",
        },
      })
    end,
  })

  -- Fancier statusline and bufferline
  use({
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
  })
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
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
  })
  use("kyazdani42/nvim-web-devicons") -- More icons

  -- Better quickfix list
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  })

  -- Indentation guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  })

  -- Peek lines of a buffer
  use({
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  })

  -- Improve the default vim.ui interfaces
  use({
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
        },
      })
    end,
  })
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
  })

  -- Scrollbar with diagnostics
  use({
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup()
    end,
  })

  -- Flash cursor when jumping
  use({
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
  })

  -- Fancy dashboard
  use({
    "goolord/alpha-nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.alpha")
    end,
  })

  -- Highlight todo comments
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
  })

  -- Manage and display key bindings
  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  })

  -- Nice diagnostics in virtual text
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("lsp_lines").setup()
    end,
  })
end)

require("plugins.cmp")
