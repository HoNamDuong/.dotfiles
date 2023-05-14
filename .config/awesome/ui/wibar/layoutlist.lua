local awful = require("awful")
local wibox = require("wibox")

local layoutlist = {
    layout = wibox.layout.fixed.horizontal,
    awful.widget.layoutlist({
        widget_template = {
            {
                {
                    id = "icon_role",
                    widget = wibox.widget.imagebox,
                },
                margins = 6,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    }),
}

return layoutlist
