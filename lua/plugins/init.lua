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
  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
  })

  -- Edit surroundings
  use({
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
  })
  use("tpope/vim-repeat")

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
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

  -- Annotation generator
  use({
    "danymat/neogen",
    cmd = "Neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
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

  -- LSP loading progress
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots",
        },
      })
    end,
  })

  -- Show signature of function calls
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_prefix = "🦔 ",
      })
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

  -- Autocompletion ------------------------------------------------------------

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-path")
  use({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup()
    end,
  })

  use("L3MON4D3/LuaSnip") -- Snippets plugin
  use("rafamadriz/friendly-snippets")

  -- Git ----------------------------------------------------------------------

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup({
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

  -- UI improvements -----------------------------------------------------------

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
        inverse = {
          match_paren = true,
        },
      })
    end,
  })

  -- Fancier statusline and bufferline
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  })
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          always_show_bufferline = false,
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
      require("indent_blankline").setup()
    end,
  })

  -- Display a character as the colorcolumn
  use({
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  })

  -- Stabilize buffer content on window open/close
  use({
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
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

  -- Scrollbar with diagnostics
  use({
    "petertriho/nvim-scrollbar",
    requires = "~/.config/nvim/onenord.nvim",
    config = function()
      local colors = require("onenord.colors").load()

      require("scrollbar").setup({
        handle = {
          color = colors.selection,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warn },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
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
      require("todo-comments").setup()
    end,
  })

  -- Manage and display key bindings
  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  })
end)

require("plugins.cmp")
