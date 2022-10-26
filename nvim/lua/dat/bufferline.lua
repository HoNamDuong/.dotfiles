local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end

bufferline.setup({
    options = {
        offsets = {
            { filetype = "NvimTree", text = "", padding = 1 },
            { filetype = "packer", text = "", padding = 1 },
            { filetype = "Outline", text = "", padding = 1 },
        },
        indicator = { style = "none" },
        separator_style = "thich",
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
})
