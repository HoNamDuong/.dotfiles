local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        multi_icon = "  ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "yarn.lock" },
        mappings = {
            i = {
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<esc>"] = actions.close,
            },
        },
    },
    extensions = {
        project = {
            hidden_files = false, -- default: false
            sync_with_nvim_tree = true, -- default false
        },
    },
})

telescope.load_extension("project")
