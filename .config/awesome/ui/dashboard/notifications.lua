local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

local notifications = wibox.widget({
    {
        {
            {
                markup = pango.b("Notifications"),
                align = "center",
                valign = "center",
                font = beautiful.font_name .. " " .. 18,
                widget = wibox.widget.textbox,
            },
            nil,
            {
                {
                    {
                        markup = pango.b("Clear"),
                        align = "center",
                        valign = "center",
                        widget = wibox.widget.textbox,
                        buttons = {
                            awful.button({}, 1, function()
                                naughty.notification_list:reset()
                            end),
                        },
                    },
                    margins = dpi(3),
                    widget = wibox.container.margin,
                },
                fg = beautiful.palette.background,
                bg = beautiful.palette.urgent,
                widget = wibox.container.background,
            },
            layout = wibox.layout.align.horizontal,
        },
        naughty.notification_list,
        spacing = beautiful.useless_gap * 2,
        layout = wibox.layout.fixed.vertical,
    },
    margins = beautiful.useless_gap * 2,
    widget = wibox.container.margin,
})

return notifications
