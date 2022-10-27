local status, lualine = pcall(require, "lualine")
if not status then
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    always_visible = true,
    padding = 1,
}

local filetype = {
    "filetype",
    icons_enabled = false,
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            -- "packer",
            -- "NvimTree",
            -- "lspinfo",
            -- "null-ls-info",
            -- "mason",
        },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "branch", "diff", diagnostics },
        lualine_x = { filetype, spaces, "encoding", "location", "progress" },
        lualine_y = {},
        lualine_z = { "mode" },
    },
})
