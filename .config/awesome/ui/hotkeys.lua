local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi

local hotkeys = hotkeys_popup.widget.new({
    width = dpi(60) * 20,
    height = dpi(60) * 13,
})

return hotkeys
