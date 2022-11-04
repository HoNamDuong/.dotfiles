local status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

configs.setup({
    auto_install = true,
    highlight = { enable = true },
    autopairs = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
})
