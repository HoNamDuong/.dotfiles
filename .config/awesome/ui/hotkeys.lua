local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi

local hotkeys = hotkeys_popup.widget.new({
    width = dpi(1200),
    height = dpi(700),
})

return hotkeys
