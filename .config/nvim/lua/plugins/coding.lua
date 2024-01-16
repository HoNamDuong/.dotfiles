return {
    -- Auto completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")

            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            vim.api.nvim_create_user_command("LuaSnipEdit", function()
                require("luasnip.loaders").edit_snippet_files()
            end, { desc = "Edit snippet file" })

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-c>"] = cmp.mapping(function(fallback)
                        if luasnip.choice_active() then
                            luasnip.change_choice(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                formatting = {
                    expandable_indicator = true,
                    fields = { "abbr", "kind", "menu" },
                    format = function(entry, vim_item)
                        vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            path = "[Path]",
                            cmdline = "[Cmdline]",
                            nvim_lsp = "[LSP]",
                            nvim_lsp_signature_help = "[LSP Signature]",
                            luasnip = "[LuaSnip]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                cmp.setup.cmdline({ "/", "?" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "buffer" },
                    }),
                }),
                cmp.setup.cmdline({ ":" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" },
                    }, {
                        { name = "cmdline" },
                    }),
                }),
                window = {
                    documentation = cmp.config.window.bordered({ winhighlight = "Normal:NormalFloat" }),
                },
                experimental = {
                    ghost_text = true, -- this feature conflict with copilot.vim's preview.
                },
            })
        end,
    },
    -- Fast and feature-rich surround actions
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    -- Auto pairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    -- Comments
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            lazy = true,
            opts = { enable_autocmd = false },
        },
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
    },
    -- Better text-objects
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }, {}),
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }, {}),
                },
            }
        end,
    },
}
