local beautiful = require("beautiful")
local wibox = require("wibox")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

local countdown = wibox.widget({
    {
        {
            id = "text_role",
            markup = pango.span({ pango.b("Not scheduled"), foreground = beautiful.common.medium }),
            halign = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        left = dpi(6) * 2,
        right = dpi(6) * 2,
        widget = wibox.container.margin,
    },
    visible = false,
    bg = beautiful.common.medium_dark,
    widget = wibox.container.background,
})

return countdown
