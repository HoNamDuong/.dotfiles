local status, comment = pcall(require, "Comment")
if not status then
    return
end

comment.setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
})
