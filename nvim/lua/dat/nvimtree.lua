local status, nvimtree = pcall(require, "nvim-tree")
if not status then
    return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local callback = require("nvim-tree.config").nvim_tree_callback

nvimtree.setup({
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
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
                { key = "h", cb = callback("close_node") },
                { key = "v", cb = callback("vsplit") },
            },
        },
    },
})
