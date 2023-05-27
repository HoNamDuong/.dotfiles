local awful = require("awful")
local wibox = require("wibox")
local calendar = require("ui.calendar")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local clock = wibox.widget({
    {
        {
            id = "clock_icon",
            image = beautiful.calendar_icon,
            resize = true,
            halign = "center",
            widget = wibox.widget.imagebox,
        },
        margins = {
            left = dpi(6),
            right = dpi(6),
            top = dpi(3),
            bottom = dpi(3),
        },
        widget = wibox.container.margin,
    },
    {
        id = "clock_text",
        halign = "center",
        valign = "center",
        full = false,
        widget = wibox.widget.textclock("%H:%M"),
    },
    layout = wibox.layout.fixed.horizontal,
})

clock:add_button(awful.button({}, 1, nil, function()
    calendar.month:toggle()
end))

clock:add_button(awful.button({}, 3, nil, function()
    local widget = clock["clock_text"]

    if widget.full then
        widget.format = "%H:%M"
    else
        widget.format = "%A %d/%m/%Y %H:%M"
    end

    widget.full = not widget.full
end))

return clock
