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
                    Snacks.bufdelete.delete(n)
                end,
                left_mouse_command = "buffer %d",
                indicator = { style = "icon" },
                diagnostics = "nvim_lsp",
                -- always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                separator_style = "thin",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
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
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
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
        config = function()
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
                path = 1,
            }

            local lsp_clients = function()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

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
                    section_separators = "",
                    component_separators = "",
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { lsp_clients },
                    lualine_c = { "branch", "diff", diagnostics, filename },
                    lualine_x = { "filetype", "filesize", "encoding", fileformat },
                    lualine_y = { location, "progress" },
                    lualine_z = { "mode" },
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
                        },
                    },
                },
            })
        end,
    },
    -- QoL plugins
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true },
            notifier = { enabled = true },
            words = { enabled = true },
            bigfile = { enabled = true },
            dashboard = { width = 30 },
        },
        keys = {
            {
                "<leader>bd",
                function()
                    Snacks.bufdelete()
                end,
                desc = "Delete buffer",
            },
            {
                "<leader>bD",
                function()
                    Snacks.bufdelete.all()
                end,
                desc = "Delete all buffers",
            },
            {
                "<leader>nn",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notification History",
            },
        },
    },
}
