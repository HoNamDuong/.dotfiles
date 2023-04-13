local status, nullls = pcall(require, "null-ls")
if not status then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = nullls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = nullls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nullls.setup({
    debug = true,
    sources = {
        formatting.prettier.with({
            -- extra_args = {
            --     "--tab-width",
            --     "4",
            --     -- "--print-width",
            --     -- "120",
            --     "--no-semi",
            --     "--single-quote",
            --     "--jsx-single-quote",
            -- },
        }),
        formatting.stylua.with({
            extra_args = {
                "--indent-type",
                "Spaces",
                "--column-width",
                "200",
            },
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
