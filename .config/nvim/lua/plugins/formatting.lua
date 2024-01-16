return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>lf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "v" },
            desc = "Format document",
        },
    },
    opts = {
        -- Define formatters
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
        },
        -- Customize formatters
        formatters = {
            ["stylua"] = {
                prepend_args = {
                    "--indent-type",
                    "Spaces",
                    "--column-width",
                    "200",
                },
            },
            ["prettier"] = {
                prepend_args = {
                    "--tab-width",
                    "4",
                    "--print-width",
                    "120",
                    "--no-semi",
                    "--single-quote",
                    "--config-precedence",
                    "file-override",
                },
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
