local status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

configs.setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    auto_install = true,
    highlight = { enable = false },
    autopairs = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
})
