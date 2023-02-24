local status, _ = pcall(require, "lspconfig")
if not status then
    return
end

require("lspconfig.ui.windows").default_options.border = "single"

require("lsp.mason")
require("lsp.handlers").setup()
require("lsp.nullls")
