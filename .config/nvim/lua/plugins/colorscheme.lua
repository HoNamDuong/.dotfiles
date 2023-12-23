return {
    -- Tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                style = "night",
                on_highlights = function(highlights, colors)
                    highlights.WinSeparator = {
                        fg = colors.comment,
                    }
                end,
            })

            vim.cmd.colorscheme('tokyonight')
        end,
    },
}
