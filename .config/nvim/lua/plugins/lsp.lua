-- List mason.nvim package name
local packages = {
    "stylua",
    "prettier",
}
-- List lspconfig server name
local servers = {
    "lua_ls",
    "html",
    "cssls",
    "tailwindcss",
    "emmet_ls",
    "jsonls",
    "tsserver",
    "intelephense",
    "clangd",
}

return {
    -- LSP config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neodev.nvim", opts = {} },
            "b0o/schemastore.nvim",
        },
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"

            local lspconfig = require("lspconfig")

            local on_attach = function(client, bufnr)
                local keymap = vim.api.nvim_buf_set_keymap
                keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto declaration" })
                keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Goto definition" })
                keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Goto type definitions" })
                keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Goto references" })
                keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Goto implementations" })

                keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
                keymap(bufnr, "n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
                keymap(bufnr, "i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })

                keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", { desc = "Previous diagnostic" })
                keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", { desc = "Next diagnostic" })

                keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Renames" })
                keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Renames" })
                keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
                keymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show line diagnostics" })
                keymap(bufnr, "n", "<leader>l<CR>", "<cmd>LspInfo<CR>", { desc = "LSP information" })

                require("illuminate").on_attach(client)

                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end

            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- List setting for LSP server
            local settings = {
                ["lua_ls"] = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },
                ["jsonls"] = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
            }

            for _, server in pairs(servers) do
                local opts = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }

                server = vim.split(server, "@")[1]

                if settings[server] then
                    opts = vim.tbl_deep_extend("force", settings[server], opts)
                end

                lspconfig[server].setup(opts)
            end
        end,
    },
    -- Cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup({ max_concurrent_installers = 2, ui = { border = "rounded" } })
            require("mason-lspconfig").setup()

            local registry = require("mason-registry")
            registry:on(
                "package:handle",
                vim.schedule_wrap(function(pkg, handle)
                    print(string.format("Installing %s", pkg.name))
                end)
            )
            registry:on(
                "package:install:success",
                vim.schedule_wrap(function(pkg, handle)
                    print(string.format("%s was successfully installed", pkg.name))
                end)
            )

            local lspconfig_to_mason = require("mason-lspconfig").get_mappings().lspconfig_to_mason
            for _, server in ipairs(servers) do
                table.insert(packages, lspconfig_to_mason[server])
            end

            local function ensure_installed()
                for _, tool in ipairs(packages) do
                    local p = registry.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
