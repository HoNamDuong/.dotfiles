local status, _ = pcall(require, "tokyonight")
if not status then
    return
end

vim.cmd([[colorscheme tokyonight-night]])

-- local status, _ = pcall(require, "kanagawa")
-- if not status then
--     return
-- end
-- vim.cmd([[colorscheme kanagawa]])
