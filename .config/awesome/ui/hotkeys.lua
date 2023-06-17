local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi

local hotkeys = hotkeys_popup.widget.new({
    width = dpi(6) * 10 * 20,
    height = dpi(6) * 10 * 13,
})

return hotkeys
