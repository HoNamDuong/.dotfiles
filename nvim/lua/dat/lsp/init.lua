local status, _ = pcall(require, "lspconfig")
if not status then
	return
end

require("dat.lsp.mason")
require("dat.lsp.handlers").setup()
require("dat.lsp.null-ls")
