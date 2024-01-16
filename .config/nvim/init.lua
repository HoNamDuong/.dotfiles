require("core.options")
require("core.keymaps")
require("core.autocommands")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
    ui = { border = "rounded" },
    checker = {
        enabled = true, -- automatically check for plugin updates
        notify = false, -- get a notification when new updates are found
    },
    change_detection = {
        enabled = true, -- automatically check for config file changes and reload the ui
        notify = false, -- get a notification when changes are found
    },
    install = {
        colorscheme = { "hybrid" }, -- try to load one of these colorschemes when starting an installation during startup
    },
})
