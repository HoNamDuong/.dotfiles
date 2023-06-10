local beautiful = require("beautiful")
local wibox = require("wibox")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

local countdown = wibox.widget({
    {
        {
            {
                id = "countdown_text",
                markup = pango.span({ pango.b("Not scheduled"), foreground = beautiful.palette.yellow }),
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            left = dpi(6) * 2,
            right = dpi(6) * 2,
            widget = wibox.container.margin,
        },
        visible = false,
        bg = beautiful.palette.yellow_30,
        widget = wibox.container.background,
    },
    left = dpi(6),
    widget = wibox.container.margin,
})

return countdown
