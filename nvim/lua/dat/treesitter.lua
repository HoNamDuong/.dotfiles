local status, treesitter = pcall(require, "nvim-treesitter")
if not status then
    return
end

local statusconfig, configs = pcall(require, "nvim-treesitter.configs")
if not statusconfig then
    return
end

configs.setup({
    ensure_installed = {
        "html",
        "css",
        "gitignore",
        "javascript",
        "typescript",
        "lua",
        "markdown",
        "bash",
        "python",
        "vim",
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    autopairs = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
})
