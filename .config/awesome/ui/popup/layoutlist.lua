local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local layoutlist = awful.popup({
    widget = awful.widget.layoutlist({
        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(6),
                    widget = wibox.container.margin,
                },
                {
                    id = "text_role",
                    halign = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.vertical,
            },
            id = "background_role",
            forced_width = dpi(120),
            forced_height = dpi(150),
            widget = wibox.container.background,
        },
    }),
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

return layoutlist
