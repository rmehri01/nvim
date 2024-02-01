local lspconfig = require("lspconfig")
local on_attach = require("plugins.utils").on_attach
local capabilities = require("plugins.utils").capabilities

-- Enable the following language servers
local servers = { "clangd", "hls", "pyright", "gopls", "tsserver", "jsonls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.rust_analyzer.setup({
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
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        -- Tell the language server which version of Lua to use (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data
      telemetry = {
        enable = false,
      },
    },
  },
})
