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
        sorting_strategy = "ascending",
        dynamic_preview_title = true,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_cutoff = 100,
            },
            vertical = {
                prompt_position = "top",
                preview_cutoff = 0,
                preview_height = 5,
                mirror = true,
            },
            flex = {
                layout_config = {
                    flip_columns = 100,
                },
            },
        },
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
    pickers = {
        lsp_references = {
            theme = "cursor",
            path_display = { "tail" },
            layout_config = {
                width = 0.9,
                height = 10,
            },
        },
        find_files = {
            layout_strategy = "flex",
        },
        oldfiles = {
            layout_strategy = "flex",
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
        },
        builtin = {
            theme = "dropdown",
            previewer = false,
        },
        filetypes = {
            theme = "dropdown",
        },
    },
    extensions = {
        project = {
            theme = "dropdown",
            sync_with_nvim_tree = true,
        },
    },
})

vim.keymap.set("n", "<leader>sB", "<cmd>Telescope builtin<CR>", { desc = "Builtin" })
vim.keymap.set("n", "<leader>sC", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "Highlight" })
vim.keymap.set("n", "<leader>sL", "<cmd>Telescope live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>sQ", "<cmd>Telescope quickfixhistory<CR>", { desc = "Lists all quickfix lists" })
vim.keymap.set("n", "<leader>sa", "<cmd>Telescope autocommands<CR>", { desc = "Lists vim autocommands" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
vim.keymap.set("n", "<leader>sj", "<cmd>Telescope jumplist<CR>", { desc = "Lists jump" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
vim.keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles<CR>", { desc = "Recent file" })
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope project display_type=full<CR>", { desc = "Projects" })
vim.keymap.set("n", "<leader>sq", "<cmd>Telescope quickfix<CR>", { desc = "Lists items in the quickfix list" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope registers<CR>", { desc = "Registers" })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope filetypes<CR>", { desc = "Filetype" })
vim.keymap.set("n", "<leader>sv", "<cmd>Telescope vim_options<CR>", { desc = "Lists vim options" })

vim.keymap.set("n", "<leader>sT", "<cmd>Telescope treesitter<CR>", { desc = "Function, variables from Treesitter" })

vim.keymap.set("n", "<leader>sgC", "<cmd>Telescope git_bcommits<CR>", { desc = "Buffer's git commits" })
vim.keymap.set("n", "<leader>sgc", "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })
vim.keymap.set("n", "<leader>sgb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout branch" })
vim.keymap.set("n", "<leader>sgf", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
vim.keymap.set("n", "<leader>sgs", "<cmd>Telescope git_status<CR>", { desc = "Open changed file" })
vim.keymap.set("n", "<leader>sgt", "<cmd>Telescope git_stash<CR>", { desc = "Stash items" })

vim.keymap.set("n", "<leader>slr", "<cmd>Telescope lsp_referencesCR>", { desc = "Lists LSP references" })
vim.keymap.set("n", "<leader>sli", "<cmd>Telescope lsp_incoming_callsCR>", { desc = "Lists LSP incoming calls" })
vim.keymap.set("n", "<leader>slo", "<cmd>Telescope lsp_outgoing_callsCR>", { desc = "Lists LSP outgoing calls" })
vim.keymap.set("n", "<leader>sls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
vim.keymap.set("n", "<leader>slS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>sly", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Dynamically all workspace symbols" })
vim.keymap.set("n", "<leader>sld", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>slD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>slf", "<cmd>Telescope lsp_definitions<CR>", { desc = "Goto the definition" })
vim.keymap.set("n", "<leader>sli", "<cmd>Telescope lsp_implementations<CR>", { desc = "Goto the implementation" })
vim.keymap.set("n", "<leader>slt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Goto the definition of the type" })

telescope.load_extension("project")
telescope.load_extension("fzf")
