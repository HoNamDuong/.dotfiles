local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local clock = wibox.widget({
    {
        id = "icon_role",
        image = beautiful.clock_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        {
            id = "date_role",
            format = "%A %d/%m/%Y ",
            halign = "center",
            valign = "center",
            visible = false,
            widget = wibox.widget.textclock(),
        },
        {
            id = "time_role",
            format = "%H:%M",
            halign = "center",
            valign = "center",
            widget = wibox.widget.textclock(),
        },
        layout = wibox.layout.fixed.horizontal,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
})

clock:add_button(awful.button({}, 1, nil, function()
    local status = clock:get_children_by_id("date_role")[1].visible
    clock:get_children_by_id("date_role")[1].visible = not status
end))

return clock
