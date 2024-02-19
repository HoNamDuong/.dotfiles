local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local systray = wibox.container.margin({
    {
        horizontal = true,
        widget = wibox.widget.systray(),
    },
    top = dpi(2),
    bottom = dpi(2),
    left = dpi(6),
    right = dpi(6),
    color = beautiful.bg_systray,
    widget = wibox.container.margin,
})

return systray
