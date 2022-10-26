local status, onedark = pcall(require, "onedark")
if not status then
    return
end
onedark.setup({
    style = "dark",
    highlights = {
        ["NormalFloat"] = { bg = "#20252c", fg = "#abb2bf" },
        ["FloatBorder"] = { bg = "#20252c", fg = "#abb2bf" },
        ["Pmenu"] = { bg = "#20252c", fg = "#abb2bf" },
        ["PmenuSel"] = { bg = "#3b3f4c", fg = "NONE" },
        ["CmpItemAbbrMatchFuzzy"] = { fg = "NOME", bg = "NONE", fmt = "underline" },
        ["CmpItemAbbrMatch"] = { fg = "#61afef", bg = "NONE" },
        ["TelescopeBorder"] = { fg = "#3b3f4c", bg = "NONE" },
    ["TelescopeResultsBorder"] = { fg = "#3b3f4c", bg = "NONE" },
        ["TelescopePreviewBorder"] = { fg = "#3b3f4c", bg = "NONE" },
        ["TelescopePromptBorder"] = { fg = "#3b3f4c", bg = "NONE" },
        ["IndentBlanklineContextChar"] = { fg = "#61afef", bg = "NONE" },
    },
})

onedark.load()
