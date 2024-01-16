return {
    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.bufremove",
        },
        opts = {
            options = {
                right_mouse_command = "buffer %d",
                middle_mouse_command = function(n)
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(n)
                        elseif choice == 2 then -- No
                            bd(n, true)
                        end
                    else
                        bd(n)
                    end
                end,
                left_mouse_command = "buffer %d",
                indicator = { style = "icon" },
                diagnostics = "nvim_lsp",
                -- always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                separator_style = {},
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        highlight = "Title",
                        separator = true,
                    },
                    {
                        filetype = "spectre_panel",
                        text = "Find and replate",
                        text_align = "center",
                        highlight = "Title",
                        separator = true,
                    },
                },
            },
            highlights = {
                hint = { fg = { attribute = "fg", highlight = "DiagnosticHint" } },
                info = { fg = { attribute = "fg", highlight = "DiagnosticInfo" } },
                warning = { fg = { attribute = "fg", highlight = "DiagnosticWarn" } },
                error = { fg = { attribute = "fg", highlight = "DiagnosticError" } },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "SmiteshP/nvim-navic",
        },
        config = function()
            local navic = require("nvim-navic")

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = "E",
                    warn = "W",
                    info = "I",
                    hint = "H",
                },
                always_visible = false,
            }

            local location = {
                "%l/%L:%v",
            }

            local fileformat = {
                "fileformat",
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
            }

            local filename = {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 3,
            }

            local lsp_progress = function()
                if #vim.lsp.get_active_clients() == 0 then
                    return ""
                end
                local lsp = vim.lsp.util.get_progress_messages()[1]
                if lsp then
                    local name = lsp.name or ""
                    local msg = lsp.message or ""
                    local percentage = lsp.percentage or 0
                    local title = lsp.title or ""
                    return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
                end
                return ""
            end

            local lsp_clients = function()
                local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })

                if next(clients) == nil then
                    return "No LSP"
                end

                local list = {}

                for _, client in ipairs(clients) do
                    table.insert(list, client.name)
                end

                if next(list) == nil then
                    return "No LSP"
                else
                    return "LSP:" .. table.concat(list, ",")
                end
            end

            require("lualine").setup({
                options = {
                    -- icons_enabled = false,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        winbar = {
                            "dap-repl",
                        },
                    },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { lsp_clients, lsp_progress },
                    lualine_c = { "branch", "diff", diagnostics, filename },
                    lualine_x = { "filetype", "filesize", "encoding", fileformat },
                    lualine_y = { location, "progress" },
                    lualine_z = { "mode" },
                },
                winbar = {
                    lualine_c = {
                        {
                            function()
                                return navic.get_location()
                            end,
                            cond = function()
                                return navic.is_available()
                            end,
                        },
                    },
                },
                extensions = {
                    {
                        sections = {
                            lualine_c = {
                                function()
                                    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                                end,
                            },
                            lualine_x = { location, "progress" },
                        },
                        filetypes = {
                            "NvimTree",
                            "spectre_panel",
                        },
                    },
                },
            })
        end,
    },
    -- Breadcrumbs
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = {
            highlight = true,
            click = true,
        },
    },
    -- Indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "dashboard",
                },
            },
        },
        main = "ibl",
    },
    {
        "nvimdev/dashboard-nvim",
        -- enabled = false,
        event = "VimEnter",
        opts = function()
            local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

            logo = string.rep("\n", 4) .. logo .. "\n\n"

            local opts = {
                theme = "doom",
                config = {
                    header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files",              desc = " Find file",        key = "f" },
                        { action = "ene | startinsert",                 desc = " New file",         key = "n" },
                        { action = "Telescope oldfiles",                desc = " Recent files",     key = "r" },
                        { action = "Telescope live_grep",               desc = " Find text",        key = "g" },
                        { action = 'lua require("persistence").load()', desc = " Restore Session",  key = "s" },
                        { action = "Lazy",                              desc = " Lazy",             key = "l" },
                        { action = "qa",                                desc = " Quit",             key = "q" },
                    },
                    -- stylua: ignore end
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 30 - #button.desc)
                button.key_format = " %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
}
