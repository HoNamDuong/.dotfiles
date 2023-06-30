local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")
local dpi = require("beautiful.xresources").apply_dpi

local powermenu = wibox.widget({
    {
        {
            image = beautiful.lock_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    awful.spawn(config.actions.lock)
                end),
            },
        },
        margins = dpi(6) * 4,
        widget = wibox.container.margin,
    },
    {
        {
            image = beautiful.logout_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    awful.spawn(config.actions.logout)
                end),
            },
        },
        margins = dpi(6) * 4,
        widget = wibox.container.margin,
    },
    -- {
    --     {
    --         image = beautiful.sleep_icon,
    --         resize = true,
    --         halign = "center",
    --         valign = "center",
    --         widget = wibox.widget.imagebox,
    --         buttons = {
    --             awful.button({}, 1, function()
    --                 awful.spawn(config.actions.sleep)
    --             end),
    --         },
    --     },
    --     margins = dpi(6) * 4,
    --     widget = wibox.container.margin,
    -- },
    {
        {
            image = beautiful.restart_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    awful.spawn(config.actions.restart)
                end),
            },
        },
        margins = dpi(6) * 4,
        widget = wibox.container.margin,
    },
    {
        {
            image = beautiful.shutdown_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    awful.spawn(config.actions.shutdown)
                end),
            },
        },
        margins = dpi(6) * 4,
        widget = wibox.container.margin,
    },
    layout = wibox.layout.flex.vertical,
})

return powermenu
