local status, navic = pcall(require, "nvim-navic")
if not status then
    return
end

navic.setup({
    highlight = true,
})
