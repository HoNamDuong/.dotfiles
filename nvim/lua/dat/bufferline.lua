local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end

bufferline.setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
            },
        },
        indicator = { style = "none" },
        separator_style = "thich",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})
