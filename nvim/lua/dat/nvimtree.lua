vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status, nvimtree = pcall(require, "nvim-tree")
if not status then
    return
end

-- local callback = require("nvim-tree.config").nvim_tree_callback

nvimtree.setup({
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    filters = {
        custom = { "/.git" },
    },
    git = {
        ignore = false,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 25,
        side = "left",
        mappings = {
            list = {
                -- { key = "v", cb = callback("vsplit") },
                -- { key = "s", cb = callback("split") },
            },
        },
    },
})
