local status_lualine, lualine = pcall(require, "lualine")
if not status_lualine then
    return
end

local status_navic, navic = pcall(require, "nvim-navic")
if not status_navic then
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    always_visible = false,
    padding = 1,
}

local filetype = {
    "filetype",
    icons_enabled = false,
}

local location = {
    "%l/%L:%v",
    padding = 1,
}

local fileformat = {
    "fileformat",
    icons_enabled = true,
    symbols = {
        unix = "LF",
        dos = "CRLF",
        mac = "CR",
    },
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_progress = function()
    if #vim.lsp.buf_get_clients() == 0 then
        return ""
    end
    local lsp = vim.lsp.util.get_progress_messages()[1]
    if lsp then
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end
    return ""
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
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "branch", "diff", diagnostics, lsp_progress },
        lualine_x = { filetype, spaces, fileformat, "encoding", location, "progress" },
        lualine_y = { "filesize" },
        lualine_z = { "mode" },
    },
    winbar = {
        lualine_c = { { navic.get_location, cond = navic.is_available } },
    },
})
