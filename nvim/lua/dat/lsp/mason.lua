local servers = {
    "sumneko_lua",
    "html",
    "cssls",
    "emmet_ls",
    "tsserver",
}

local settings = {
    ui = {
        border = "rounded",
    },
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local status, lspconfig = pcall(require, "lspconfig")
if not status then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("dat.lsp.handlers").on_attach,
        capabilities = require("dat.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "dat.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end
