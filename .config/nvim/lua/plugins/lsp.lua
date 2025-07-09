-- List LSP server name
local lsp_servers = {
    -- LSP
    "lua_ls",
    "clangd",
    "ts_ls",
    "emmet_ls",
    "html",
    "cssls",
    "tailwindcss",
    "intelephense",
    "jsonls",
    "pylsp",
}
-- List mason.nvim server name
local other_servers = {
    -- Formatter
    "stylua",
    "prettier",
    "shfmt",
    -- DAP
    "js-debug-adapter",
    "codelldb",
    -- Linter
    "cspell",
    "eslint_d",
    "cpplint",
}
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
                validate = { enable = true },
            },
        },
    },
}

vim.api.nvim_create_autocmd("LspNotify", {
    callback = function(args)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, { buffer = args.buf })
        vim.keymap.set("i", "<C-s>", function()
            vim.lsp.buf.signature_help({ border = "rounded" })
        end, { buffer = args.buf })
    end,
})

return {
    -- LSP config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>l<CR>", "<cmd>LspInfo<CR>", desc = "LSP information" },
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
            })

            for key, _ in pairs(settings) do
                if settings[key] ~= nil then
                    vim.lsp.config(key, settings[key])
                end
            end
        end,
    },
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        dependencies = { "mason-org/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup({ max_concurrent_installers = 2 })
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

            local lspconfig_to_package = require("mason-lspconfig").get_mappings().lspconfig_to_package
            for _, server in ipairs(lsp_servers) do
                table.insert(other_servers, lspconfig_to_package[server])
            end

            local function ensure_installed()
                for _, tool in ipairs(other_servers) do
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
