local status, _ = pcall(require, "lspconfig")
if not status then
    return
end

require("lspconfig.ui.windows").default_options.border = "single"

require("dat.lsp.mason")
require("dat.lsp.handlers").setup()
require("dat.lsp.nullls")
