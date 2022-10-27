local status, cmp = pcall(require, "cmp")
if not status then
    return
end

local snip_status, luasnip = pcall(require, "luasnip")
if not snip_status then
    return
end

local kind_status, lspkind = pcall(require, "lspkind")
if not kind_status then
    return
end

require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/snippets" } })

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- local kind_icons = {
--     Text = " Text",
--     Method = " Method",
--     Function = " Function",
--     Constructor = " Constructor",
--     Field = " Field",
--     Variable = " Variable",
--     Class = "ﴯ Class",
--     Interface = " Interface",
--     Module = " Module",
--     Property = "ﰠ Property",
--     Unit = " Unit",
--     Value = " Value",
--     Enum = " Enum",
--     Keyword = " Keyword",
--     Snippet = " Snippet",
--     Color = " Color",
--     File = " File",
--     Reference = " Reference",
--     Folder = " Folder",
--     EnumMember = " EnumMember",
--     Constant = " Constant",
--     Struct = " Struct",
--     Event = " Event",
--     Operator = " Operator",
--     TypeParameter = " TypeParameter",
-- }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
        keyword_length = 2,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 25,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    nvim_lsp_signature_help = "[LSP S]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        }),
        -- fields = { "abbr", "kind", "menu" },
        -- format = function(entry, vim_item)
        --     vim_item.kind = kind_icons[vim_item.kind]
        --     vim_item.menu = ({
        --         buffer = "[Buffer]",
        --         nvim_lsp = "[LSP]",
        --         nvim_lsp_signature_help = "[LSP S]",
        --         luasnip = "[LuaSnip]",
        --         nvim_lua = "[Lua]",
        --         latex_symbols = "[LaTeX]",
        --         path = "[Path]",
        --     })[entry.source.name]
        --     return vim_item
        -- end,
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "path" },
    },
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
    }),
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
    },
})