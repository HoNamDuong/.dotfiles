local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local utils = require("utils")
local keys = require("config").keys

local minimization = wibox.widget({
    {
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    bg = beautiful.colors.primary_dark,
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, nil, function()
            utils.client.toggle_minimization_clients()
        end),
    },
})

awful.tooltip({
    objects = { minimization },
    text = "Click to toggle minimization",
    align = "bottom",
    mode = "outside",
})

awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "z", function()
        utils.client.toggle_minimization_clients()
    end, { description = "Toggle minimization", group = "awesome" }),
})

return minimization
