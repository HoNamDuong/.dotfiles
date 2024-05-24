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
                    scaling_quality = "fast",
                    widget = wibox.widget.imagebox,
                },
                top = dpi(2) * 2,
                bottom = dpi(2) * 2,
                left = dpi(6),
                right = dpi(6),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

return layoutlist
