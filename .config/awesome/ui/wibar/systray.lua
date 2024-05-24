local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local systray = wibox.widget({
    {
        {
            widget = wibox.widget.systray(),
        },
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    bg = beautiful.bg_systray,
    widget = wibox.container.background,
})

return systray
