return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            -- -- disable netrw
            -- vim.g.loaded_netrw = 1
            -- vim.g.loaded_netrwPlugin = 1

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
                                unmerged = "C",
                                renamed = "R",
                                untracked = "U",
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

            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
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
                    lsp_references = {
                        theme = "cursor",
                        path_display = { "tail" },
                        layout_config = {
                            width = 0.9,
                            height = 10,
                        },
                    },
                    lsp_definitions = {
                        layout_strategy = "flex",
                    },
                    lsp_implementations = {
                        layout_strategy = "flex",
                    },
                },
            })

            -- Other
            vim.keymap.set("n", "<leader>s<CR>", "<cmd>Telescope builtin<CR>", { desc = "Builtin" })
            vim.keymap.set("n", "<leader>su", "<cmd>Telescope resume<CR>", { desc = "Resume" })
            -- File
            vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Find file" })
            vim.keymap.set("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent file" })
            vim.keymap.set("n", "<leader>s/", "<cmd>Telescope live_grep<CR>", { desc = "Grep" })
            -- Vim
            vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
            vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
            vim.keymap.set("n", "<leader>s;", "<cmd>Telescope commands<CR>", { desc = "Commands" })
            vim.keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man pages" })
            vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "help pages" })
            vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "Highlight" })
            vim.keymap.set("n", "<leader>sc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
            vim.keymap.set("n", "<leader>st", "<cmd>Telescope filetypes<CR>", { desc = "Filetype" })
            -- Treesitter
            vim.keymap.set("n", "<leader>sT", "<cmd>Telescope treesitter<CR>", { desc = "Lists function, variables" })
            -- Git
            vim.keymap.set("n", "<leader>sgb", "<cmd>Telescope git_branches<CR>", { desc = "Lists all branches" })
            vim.keymap.set("n", "<leader>sgc", "<cmd>Telescope git_commits<CR>", { desc = "Lists git commits" })
            vim.keymap.set("n", "<leader>sgC", "<cmd>Telescope git_bcommits<CR>", { desc = "Lists buffer's git commits" })
            vim.keymap.set("n", "<leader>sgs", "<cmd>Telescope git_status<CR>", { desc = "Lists current changes" })
            -- LSP
            vim.keymap.set("n", "<leader>sld", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Document diagnostics" })
            vim.keymap.set("n", "<leader>slD", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics" })

            telescope.load_extension("fzf")
        end,
    },
    -- Super fast git decorations
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "[g", function()
                        if vim.wo.diff then
                            return "[g"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Prev hunk" })
                    map("n", "]g", function()
                        if vim.wo.diff then
                            return "]g"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Next hunk" })

                    -- Actions
                    map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("x", "<leader>gs", function()
                        gs.stage_hunk({ vim.fn.line("v"), vim.fn.getpos(".")[2] })
                    end, { desc = "Stage selected hunk(s)" })
                    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("x", "<leader>gr", function()
                        gs.reset_hunk({ vim.fn.line("v"), vim.fn.getpos(".")[2] })
                    end, { desc = "Reset selected hunk(s)" })
                    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>gd", gs.diffthis, { desc = "Diffview with revision" })
                    map("n", "<leader>gD", function()
                        gs.diffthis("~")
                    end, { desc = "Diffview with commit" })
                    map("n", "<leader>gb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "Blame line" })
                    -- Toggle
                    map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle current blame line" })
                    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
                    map("n", "<leader>gth", gs.toggle_linehl, { desc = "Toggle line highlighting" })
                    map("n", "<leader>gtn", gs.toggle_numhl, { desc = "Toggle number highlighting" })
                    map("n", "<leader>gts", gs.toggle_signs, { desc = "Toggle sign column" })
                    map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Toggle word diff" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
    -- Automatically highlighting other uses of the word under
    {
        "RRethy/vim-illuminate",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
            filetypes_denylist = {
                "NvimTree",
                "DressingSelect",
                "TelescopePrompt",
                "dashboard",
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            vim.keymap.set("n", "[[", function()
                require("illuminate").next_reference({ reverse = true, wrap = true })
            end, { desc = "Prev Reference", noremap = true })
            vim.keymap.set("n", "]]", function()
                require("illuminate").next_reference({ wrap = true })
            end, { desc = "Next Reference", noremap = true })
        end,
    },
    -- High-performance color highlighter
    {
        "echasnovski/mini.hipatterns",
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
    -- Search/replace in multiple files
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            {
                "<leader>f",
                function()
                    require("spectre").toggle()
                end,
                desc = "Find and replace",
            },
        },
    },
    -- Buffer remove
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function()
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(0)
                        elseif choice == 2 then -- No
                            bd(0, true)
                        end
                    else
                        bd(0)
                    end
                end,
                desc = "Delete buffer",
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
            { "<leader>ns", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>nl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>nd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },
    -- Which Key
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local whichkey = require("which-key")

            whichkey.setup({
                icons = {
                    group = "+ ", -- symbol prepended to a group
                },
                window = {
                    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
                    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
                },
                layout = {
                    height = { min = 1, max = 25 }, -- min and max height of the columns
                    width = { min = 15, max = 100 }, -- min and max width of the columns
                    spacing = 2, -- spacing between columns
                    align = "center", -- align columns left, center or right
                },
                disable = {
                    buftypes = {},
                    filetypes = {
                        "NvimTree",
                        "TelescopePrompt",
                        "spectre_panel",
                        "lspinfo",
                        "mason",
                    },
                },
            })

            whichkey.register({
                [";"] = { name = "Commands" },
                ["<Tab>"] = { name = "Tab" },
                ["t"] = { name = "Toggle" },
                ["b"] = { name = "Buffer" },
                ["n"] = { name = "Session" },
                ["l"] = {
                    mode = { "n", "v" },
                    name = "LSP",
                },
                ["d"] = {
                    mode = { "n", "v" },
                    name = "DAP",
                },
                ["g"] = {
                    mode = { "n", "v" },
                    name = "Git",
                    ["t"] = { name = "Toggle" },
                },
                ["s"] = {
                    name = "Search",
                    ["g"] = { name = "Git" },
                    ["l"] = { name = "LSP" },
                },
            }, { mode = "n", prefix = "<leader>" })
        end,
    },
}
