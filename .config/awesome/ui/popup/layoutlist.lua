local awful = require("awful")
local wibox = require("wibox")

local layoutlist = awful.popup({
    widget = awful.widget.layoutlist({
        widget_template = {
            {
                {
                    id = "icon_role",
                    forced_height = 50,
                    forced_width = 50,
                    widget = wibox.widget.imagebox,
                },
                margins = 4,
                widget = wibox.container.margin,
            },
            id = "background_role",
            forced_width = 60,
            forced_height = 60,
            widget = wibox.container.background,
        },
    }),
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

return layoutlist
