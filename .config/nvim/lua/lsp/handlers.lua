local M = {}

local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_nvim_lsp then
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
        { name = "DiagnosticSignHint", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false,
        signs = {
            action = signs,
            severity = { min = vim.diagnostic.severity.WARN },
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function keymaps(bufnr)
    local keymap = vim.api.nvim_buf_set_keymap

    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Jumps to the declaration" })
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jumps to the definition" })
    -- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Displays hover information" })
    keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Displays hover information" })
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Lists all the implementations" })
    -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Lists all the references" })
    keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Lists all the references" })
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics floating window" })

    keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", { desc = "Previous diagnostic" })
    keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", { desc = "Next diagnostic" })

    keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Renames all references" })
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Renames all references" })
    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", { desc = "Formats a buffer" })
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Selects a code action available" })
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Displays signature information" })
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Add buffer diagnostics to the location list" })
    keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", { desc = "Run the code lens in the current line" })

    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "Lsp information" })
    keymap(bufnr, "n", "<leader>lR", "<cmd>LspRestart<CR>", { desc = "Lsp restart" })
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "html" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "jsonls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    keymaps(bufnr)

    local status_illuminate, illuminate = pcall(require, "illuminate")
    if not status_illuminate then
        return
    end

    illuminate.on_attach(client)

    local status_navic, navic = pcall(require, "nvim-navic")
    if not status_navic then
        return
    end

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

return M
