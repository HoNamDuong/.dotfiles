local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")
local dpi = require("beautiful.xresources").apply_dpi

local powermenu = wibox.widget({
    {
        {
            {
                image = beautiful.power_lock,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn(config.power.lock)
                    end),
                },
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        {
            {
                image = beautiful.power_logout,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn(config.power.logout)
                    end),
                },
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        {
            {
                image = beautiful.power_sleep,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn(config.power.sleep)
                    end),
                },
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        {
            {
                image = beautiful.power_restart,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn(config.power.restart)
                    end),
                },
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        {
            {
                image = beautiful.power_shutdown,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn(config.power.shutdown)
                    end),
                },
            },
            margins = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.flex.vertical,
    },
    margins = beautiful.useless_gap * 2,
    widget = wibox.container.margin,
})

return powermenu
