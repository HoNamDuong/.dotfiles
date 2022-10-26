local status, indentline = pcall(require, "indent_blankline")
if not status then
    return
end

indentline.setup({
    char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "packer",
        "NvimTree",
    },
})
