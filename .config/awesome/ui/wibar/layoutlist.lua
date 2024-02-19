local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local layoutlist = function(s)
    return awful.widget.layoutlist({
        layout = wibox.layout.fixed.horizontal,
        screen = s,
        widget_template = {
            {
                {
                    id = "icon_role",
                    widget = wibox.widget.imagebox,
                },
                margins = dpi(2) * 2,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

return layoutlist
