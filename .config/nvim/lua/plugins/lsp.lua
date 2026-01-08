vim.diagnostic.config({
    virtual_text = true,
    float = { border = "rounded" },
})

return {
    -- LSP server configurations
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = { { "<leader>l<CR>", "<cmd>LspInfo<CR>", desc = "LSP information" } },
    },
    -- Bridges mason.nvim with the lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        opts = { ensure_installed = {}, automatic_enable = true },
        dependencies = { "mason-org/mason.nvim", opts = {} },
    },
}
