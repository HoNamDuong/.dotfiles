local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")
require("core.autocommands")

require("lazy").setup({
    lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json", -- lockfile generated after running update.
    spec = {
        { import = "plugins" }, -- import your plugins
    },
    ui = {
        border = "rounded", -- The border to use for the UI window.
    },
    install = {
        colorscheme = { "hybrid" }, -- try to load one of these colorschemes when starting an installation during startup
    },
    checker = {
        enabled = true, -- automatically check for plugin updates
        notify = false, -- get a notification when new updates are found
    },
    change_detection = {
        enabled = true, -- automatically check for config file changes and reload the ui
        notify = false, -- get a notification when changes are found
    },
})
