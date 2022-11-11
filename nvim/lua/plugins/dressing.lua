local status, dressing = pcall(require, "dressing")
if not status then
    return
end

dressing.setup({
    input = {
        winblend = 0,
        get_config = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
                return { enabled = false }
            end
        end,
    },
    select = {
        get_config = function(opts)
            if opts.kind == "codeaction" then
                return {
                    backend = "builtin",
                    builtin = {
                        relative = "cursor",
                        winblend = 0,
                        min_height = { 1 },
                    },
                }
            end
        end,
    },
})
