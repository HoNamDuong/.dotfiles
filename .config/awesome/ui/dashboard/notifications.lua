local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local notifications = wibox.widget({
    {
        {
            {
                markup = "<b>Notifications</b>",
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        naughty.notification_list,
        spacing = beautiful.useless_gap * 2,
        layout = wibox.layout.fixed.vertical,
    },
    margins = beautiful.useless_gap * 2,
    widget = wibox.container.margin,
})

return notifications
