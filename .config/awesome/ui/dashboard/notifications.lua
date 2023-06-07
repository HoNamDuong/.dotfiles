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
                font = beautiful.font_name .. " " .. 14,
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
                    right = dpi(6),
                    left = dpi(6),
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
