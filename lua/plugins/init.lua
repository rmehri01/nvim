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
  use("wbthomason/packer.nvim") -- Package manager
  use("lewis6991/impatient.nvim") -- Improve startup time
  use({
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  }) -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({
    "~/.config/nvim/onenord.nvim",
    config = function()
      require("onenord").setup({
        styles = {
          keywords = "italic",
        },
      })
    end,
  }) -- Theme inspired by Atom
  use("nvim-lualine/lualine.nvim") -- Fancier statusline
  use("kyazdani42/nvim-web-devicons") -- More icons
  -- Add indentation guides even on blank lines
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup()
    end,
  })
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- Additional textobjects for treesitter
  use({ "nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter" })
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
  }) -- Collection of configurations for built-in LSP client
  use("j-hui/fidget.nvim") -- LSP loading progress
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-path")
  use("L3MON4D3/LuaSnip") -- Snippets plugin
  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
  })
  use({ "tpope/vim-repeat" })
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  })
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_prefix = "🦔 ",
      })
    end,
  })
  use({
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
  })
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = require("nvim-lightbulb").update_lightbulb,
        pattern = "*",
      })
    end,
  })
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
  use({ "nvim-treesitter/playground" })
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
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
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
    requires = "rmehri01/onenord.nvim",
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
    "danymat/neogen",
    cmd = "Neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
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
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = function()
      require("aerial").setup()
    end,
  })
  use("rafamadriz/friendly-snippets")
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
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
end)

--Set statusbar
require("lualine").setup({
  options = {
    theme = "onenord",
  },
})

-- Gitsigns
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
})

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

-- Enable telescope fzf native
require("telescope").load_extension("fzf")
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
