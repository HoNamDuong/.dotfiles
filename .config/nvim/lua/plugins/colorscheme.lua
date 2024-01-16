return {
    -- Tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            -- vim.cmd.colorscheme("tokyonight")
        end,
    },
    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("kanagawa")
        end,
    },
    -- Hybrid
    {
        "HoNamDuong/hybrid.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("hybrid")
        end,
    },
}
