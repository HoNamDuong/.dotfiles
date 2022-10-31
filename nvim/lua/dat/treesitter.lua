local status, _ = pcall(require, "nvim-treesitter")
if not status then
    return
end

local configs = require("nvim-treesitter.configs")

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
