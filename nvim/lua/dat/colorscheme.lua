local status, tokyonight = pcall(require, "tokyonight")
if not status then
    return
end

tokyonight.setup({
    style = "night",
    on_highlights = function(highlights, colors)
        highlights.FloatBorder = {
            bg = colors.bg_dark,
            fg = colors.comment,
        }
        highlights.TelescopeBorder = {
            bg = colors.bg_dark,
            fg = colors.comment,
        }
        highlights.LspInfoBorder = {
            bg = colors.bg_dark,
            fg = colors.comment,
        }
    end,
})

vim.cmd([[colorscheme tokyonight]])

-- local status, _ = pcall(require, "kanagawa")
-- if not status then
--     return
-- end
-- vim.cmd([[colorscheme kanagawa]])
