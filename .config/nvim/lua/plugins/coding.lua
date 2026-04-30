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
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
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
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = cmp.config.sources({
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
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
                    matching = { disallow_symbol_nonprefix_matching = false },
                }),
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
    -- Comments
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- Auto pairs
    {
        "nvim-mini/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
        },
    },
    -- Better text-objects
    {
        "nvim-mini/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                mappings = {
                    -- Disable next/last variants
                    around_next = "",
                    inside_next = "",
                    around_last = "",
                    inside_last = "",
                },
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
                    d = { "%f[%d]%d+" }, -- digits
                    e = { { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" }, "^().*()$" }, -- Word with case
                },
            }
        end,
    },
}
