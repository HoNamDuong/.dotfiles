local wibox = require("wibox")
local beautiful = require("beautiful")

local clock = wibox.widget({
    format = "%H:%M",
    halign = "center",
    valign = "center",
    font = beautiful.font_name .. " " .. 48,
    widget = wibox.widget.textclock(),
})

return clock
