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
  use("tpope/vim-repeat")
  use({
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
  })

  use({
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  })
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    requires = "kyazdani42/nvim-web-devicons",
    tag = "nightly",
    config = function()
      vim.g.nvim_tree_respect_buf_cwd = 1

      require("nvim-tree").setup({
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      })
    end,
  })
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })

  -- Tree Sitter ---------------------------------------------------------------

  -- Fast incremental parsing for highlighting, editing, and navigating code
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use({ "nvim-treesitter/playground" })
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
      local lspconfig = require("lspconfig")
      local on_attach = require("plugins.utils").on_attach
      local capabilities = require("plugins.utils").capabilities

      -- Enable the following language servers
      local servers = { "clangd" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Example custom server
      -- Make runtime files discoverable to the server
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  })
  use("j-hui/fidget.nvim") -- LSP loading progress

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
      local on_attach = require("plugins.utils").on_attach
      local capabilities = require("plugins.utils").capabilities

      require("rust-tools").setup({
        tools = {
          hover_with_actions = false,
          inlay_hints = {
            other_hints_prefix = "» ",
          },
        },
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                disabled = {
                  "unresolved-proc-macro",
                },
                enableExperimental = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      })
    end,
  })

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

  -- Git --------------------------------------------------------------------

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
  use({ "sindrets/diffview.nvim", cmd = "DiffviewOpen" })
  use({
    "danymat/neogen",
    cmd = "Neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- UI improvements --------------------------------------------------------------------

  -- Select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

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
  use({"nvim-lualine/lualine.nvim", config = function ()
require("lualine").setup()
  end})
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
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

  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" , config = function ()
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
})
  end})

  use({
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
    end,
  })

  use({
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  })

  use({
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  })

  use({
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  })

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

  use({
    "edluffy/specs.nvim",
    config = function()
      require("specs").setup({
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 7, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 30,
          winhl = "PmenuSel",
          fader = require("specs").linear_fader,
          resizer = require("specs").shrink_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
          nofile = true,
        },
      })
    end,
  })

  use({
    "goolord/alpha-nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
        "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
        "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
        "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
        "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
        "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
        "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
        " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
        " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
        "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
        "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("SPC s r", "  Recently Used Files"),
        dashboard.button("SPC s t", "  Find Word"),
        dashboard.button("SPC n", "  New File"),
        dashboard.button("SPC f", "  Find File"),
        dashboard.button("SPC P", "  Recent Projects"),
        dashboard.button("SPC C", "  Configuration"),
      }

      dashboard.config.opts.noautocmd = true

      alpha.setup(dashboard.config)
    end,
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  })
end)

-- Telescope
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

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "rust" },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  autopairs = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

-- LSP settings
require("fidget").setup({
  text = {
    spinner = "dots",
  },
})

-- To instead override globally
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- luasnip setup
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")

-- nvim-cmp setup
local icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "crates" },
    { name = "git" },
    { name = "buffer" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
