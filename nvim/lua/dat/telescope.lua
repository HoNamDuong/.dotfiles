local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = " ",
        multi_icon = "+",
        path_display = { "truncate" },
        -- wrap_results = true,
        file_ignore_patterns = { "./.git/", "node_modules", "yarn.lock" },
        mappings = {
            i = {
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<esc>"] = actions.close,
                ["<CR>"] = function()
                    vim.cmd.stopinsert()
                    vim.cmd([[call feedkeys("\<CR>")]])
                end,
            },
        },
    },
    extensions = {
        project = {
            hidden_files = false,
            sync_with_nvim_tree = true,
        },
    },
})

vim.keymap.set("n", "<leader>sC", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "Highlight" })
vim.keymap.set("n", "<leader>sB", "<cmd>Telescope builtin theme=dropdown previewer=false<CR>", { desc = "Builtin" })
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Find File" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", "<cmd>Telescope live_grep<CR>", { desc = "Find Text" })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles<CR>", { desc = "Recent File" })
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope project display_type=full theme=dropdown<CR>", { desc = "Projects" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope registers<CR>", { desc = "Registers" })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope filetypes<CR>", { desc = "Filetype" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers theme=dropdown previewer=false<CR>", { desc = "Buffers" })

vim.keymap.set("n", "<leader>sgs", "<cmd>Telescope git_status<CR>", { desc = "Open changed file" })
vim.keymap.set("n", "<leader>sgb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout branch" })
vim.keymap.set("n", "<leader>sgc", "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })

vim.keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Workspace Symbols" })
vim.keymap.set("n", "<leader>sw", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Document Diagnostics" })

telescope.load_extension("project")
