local status, tokyonight = pcall(require, "tokyonight")
if not status then
    return
end

tokyonight.setup({
    style = "night",
    transparent = true,
})

vim.cmd([[colorscheme tokyonight]])

-- local status, _ = pcall(require, "kanagawa")
-- if not status then
--     return
-- end
-- vim.cmd([[colorscheme kanagawa]])
