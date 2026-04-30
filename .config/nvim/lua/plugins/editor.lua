return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        keys = { { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" } },
        config = function()
            -- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            local function on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
            end

            require("nvim-tree").setup({
                on_attach = on_attach,
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                renderer = {
                    root_folder_label = ":t",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        glyphs = {
                            git = {
                                unstaged = "M",
                                staged = "M",
                                unmerged = "U",
                                renamed = "R",
                                untracked = "?",
                                deleted = "D",
                                ignored = "I",
                            },
                        },
                    },
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        error = "E",
                        warning = "W",
                        hint = "H",
                        info = "I",
                    },
                },
                filters = {
                    git_ignored = false,
                },
            })
        end,
    },
    -- Fuzzy finder.
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "truncate" },
                    sorting_strategy = "ascending",
                    -- wrap_results = true,
                    -- dynamic_preview_title = true,
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<ESC>"] = actions.close,
                        },
                    },
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
                },
                pickers = {
                    autocommands = {
                        layout_strategy = "vertical",
                        previewer = false,
                    },
                    find_files = {
                        layout_strategy = "flex",
                    },
                    oldfiles = {
                        layout_strategy = "flex",
                    },
                    live_grep = {
                        layout_strategy = "flex",
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                    },
                    highlights = {
                        theme = "dropdown",
                    },
                },
            })

            -- Other
            vim.keymap.set("n", "<leader>s<CR>", "<cmd>Telescope builtin<CR>", { desc = "Builtin" })
            vim.keymap.set("n", "<leader>su", "<cmd>Telescope resume<CR>", { desc = "Resume" })
            -- File
            vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Find file" })
            vim.keymap.set("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent file" })
            vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Grep" })
            -- Vim
            vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
            vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
            vim.keymap.set("n", "<leader>s;", "<cmd>Telescope commands<CR>", { desc = "Commands" })
            vim.keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
            vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "help pages" })
            vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "Highlight" })
            vim.keymap.set("n", "<leader>sc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
            vim.keymap.set("n", "<leader>st", "<cmd>Telescope filetypes<CR>", { desc = "Filetype" })

            telescope.load_extension("fzf")
        end,
    },
    -- Super fast git decorations
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                attach_to_untracked = true,
                -- diff_opts = { vertical = false },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "[g", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[g", bang = true })
                        else
                            gs.nav_hunk("prev")
                        end
                    end, { desc = "Prev hunk" })
                    map("n", "]g", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]g", bang = true })
                        else
                            gs.nav_hunk("next")
                        end
                    end, { desc = "Next hunk" })

                    -- Actions
                    map("n", "<leader>gs", gs.stage_hunk, { desc = "[Undo] Stage hunk" })
                    map("x", "<leader>gs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage selected hunk(s)" })
                    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("x", "<leader>gr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset selected hunk(s)" })
                    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>gP", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
                    map("n", "<leader>gd", gs.diffthis, { desc = "Diffview with revision" })
                    map("n", "<leader>gD", function()
                        gs.diffthis("~")
                    end, { desc = "Diffview with commit" })
                    map("n", "<leader>gb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "Blame line" })
                    map("n", "<leader>gB", gs.blame, { desc = "Blame" })
                    map("n", "<leader>gq", gs.setqflist, { desc = "Quickfix hunk(s) (current buffer)" })
                    map("n", "<leader>gQ", function()
                        gs.setqflist("all")
                    end, { desc = "Quickfix hunk(s) (working directory)" })

                    -- Toggle
                    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current blame line (gitsigns)" })
                    map("n", "<leader>th", gs.toggle_linehl, { desc = "Toggle line highlighting (gitsigns)" })
                    map("n", "<leader>td", gs.toggle_word_diff, { desc = "Toggle word diff (gitsigns)" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk (gitsigns)" })
                end,
            })
        end,
    },
    -- High-performance color highlighter
    {
        "nvim-mini/mini.hipatterns",
        version = false,
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    -- Parser generator tool
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable treesitter-based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true
        end,
    },
    -- Search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        opts = {
            helpLine = { enabled = false },
            headerMaxWidth = 80,
        },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>f",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },
    -- Session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = vim.opt.sessionoptions:get() },
        -- stylua: ignore
        keys = {
            { "<leader>ns", function() require("persistence").load() end, desc = "Restore session" },
            { "<leader>nS", function() require("persistence").select() end, desc = "Select session" },
            { "<leader>nl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
            { "<leader>nd", function() require("persistence").stop() end, desc = "Don't save current session" },
        },
    },
    -- Which Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
        },
        config = function()
            local whichkey = require("which-key")

            whichkey.add({
                { "<leader>;", group = "Commands" },
                { "<leader><Tab>", group = "Tab" },
                { "<leader>t", group = "Toggle" },
                { "<leader>b", group = "Buffer" },
                { "<leader>n", group = "Session" },
                { "<leader>s", group = "Search" },
                {
                    mode = { "n", "v" },
                    { "<leader>l", group = "LSP" },
                    { "<leader>g", group = "Git" },
                },
            })

            whichkey.setup({
                -- preset = "modern",
                win = {
                    no_overlap = false,
                    height = { min = 1, max = 30 },
                    padding = { 0, 2 },
                },
                icons = {
                    group = "+ ",
                    mappings = false,
                },
                disable = {
                    bf = {},
                    ft = {},
                },
            })
        end,
    },
}
