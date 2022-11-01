local status, tokyonight = pcall(require, "tokyonight")
if not status then
    return
end

-- local color_custom = {
--     none = "NONE",
--     bg = "#1a1b26",
--     bg_dark = "#16161e",
--     bg_highlight = "#292e42",
--     terminal_black = "#414868",
--     fg = "#c0caf5",
--     fg_dark = "#a9b1d6",
--     fg_gutter = "#3b4261",
--     dark3 = "#545c7e",
--     comment = "#565f89",
--     dark5 = "#737aa2",
--     blue0 = "#3d59a1",
--     blue = "#7aa2f7",
--     cyan = "#7dcfff",
--     blue1 = "#2ac3de",
--     blue2 = "#0db9d7",
--     blue5 = "#89ddff",
--     blue6 = "#b4f9f8",
--     blue7 = "#394b70",
--     magenta = "#bb9af7",
--     magenta2 = "#ff007c",
--     purple = "#9d7cd8",
--     orange = "#ff9e64",
--     yellow = "#e0af68",
--     green = "#9ece6a",
--     green1 = "#73daca",
--     green2 = "#41a6b5",
--     teal = "#1abc9c",
--     red = "#f7768e",
--     red1 = "#db4b4b",
--     git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
--     gitSigns = {
--         add = "#266d6a",
--         change = "#536c9e",
--         delete = "#b2555b",
--     },
-- }

tokyonight.setup({
    style = "night",
    -- on_colors = function(colors)
    -- end,
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
--------------------------------------------------------------------------------
-- local status, _ = pcall(require, "kanagawa")
-- if not status then
--     return
-- end
-- vim.cmd([[colorscheme kanagawa]])
--------------------------------------------------------------------------------
