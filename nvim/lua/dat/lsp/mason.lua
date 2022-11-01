local status_mason, mason = pcall(require, "mason")
if not status_mason then
    return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig then
    return
end

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
    return
end

local servers = {
    "sumneko_lua",
    "html",
    "cssls",
    "emmet_ls",
    "tsserver",
}

mason.setup({
    ui = { border = "rounded" },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

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
