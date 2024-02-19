local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local clock = wibox.widget({
    {
        {
            format = "%H\n%M",
            halign = "center",
            valign = "center",
            font = beautiful.font_name .. " " .. 60,
            widget = wibox.widget.textclock,
        },
        margins = dpi(6),
        widget = wibox.container.margin,
    },
    fg = beautiful.colors.foreground,
    bg = beautiful.colors.secondary_dark,
    widget = wibox.container.background,
})

return clock
