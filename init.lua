-- Try to call impatient but ignore if it isn't there
pcall(require, "impatient")

require("options")
require("autocmds")
require("lsp")
require("plugins")
require("mappings")
