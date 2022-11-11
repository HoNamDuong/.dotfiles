-- local status, satellite = pcall(require, "satellite")
-- if not status then
--     return
-- end
--
-- satellite.setup({
--     current_only = true,
--     width = 1,
--     handlers = {
--         search = {
--             enable = true,
--         },
--         diagnostic = {
--             enable = true,
--         },
--         gitsigns = {
--             enable = true,
--         },
--         marks = {
--             enable = false,
--         },
--     },
-- })

local status, scrollbar = pcall(require, "scrollbar")
if not status then
    return
end
scrollbar.setup({
    show_in_active_only = true,
    handlers = {
        cursor = false,
        gitsigns = true, -- Requires gitsigns.nvim
    },
})
