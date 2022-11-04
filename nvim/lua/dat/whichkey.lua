local status, whichkey = pcall(require, "which-key")
if not status then
    return
end

whichkey.setup({
    icons = {
        group = "+ ", -- symbol prepended to a group
    },
    window = {
        -- border = "rounded",
        margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 1, max = 25 }, -- min and max height of the columns
        width = { min = 15, max = 100 }, -- min and max width of the columns
        spacing = 2, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
    -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    triggers = "auto", -- automatically setup triggers
    -- disable the WhichKey popup for certain buf types and file types.
    disable = {
        buftypes = {},
        filetypes = {
            "NvimTree",
            "TelescopePrompt",
            "packer",
            "lspinfo",
            "null-ls-info",
            "mason",
        },
    },
})

whichkey.register({
    [";"] = { name = "Command" },
    ["<Tab>"] = { name = "Tab" },
    s = { name = "Search", g = { name = "Git" } },
    c = { name = "QuickFix" },
    t = { name = "Toggle..." },
    b = { name = "Buffer" },
    p = { name = "Packer" },
    g = { name = "Git", t = { name = "Toggle..." } },
    l = { name = "LSP" },
}, { mode = "n", prefix = "<leader>" })
