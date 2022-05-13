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
