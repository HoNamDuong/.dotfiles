local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local layoutlist = awful.popup({
    widget = awful.widget.layoutlist({
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        strategy = "exact",
                        height = dpi(60) * 2,
                        width = dpi(60) * 2,
                        widget = wibox.container.constraint,
                    },
                    {
                        id = "text_role",
                        halign = "center",
                        valign = "center",
                        font = beautiful.font,
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                margins = beautiful.useless_gap * 2,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    }),
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

return layoutlist
