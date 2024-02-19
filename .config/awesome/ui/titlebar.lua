local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local utils = require("utils")
local keys = require("config").keys

client.connect_signal("request::titlebars", function(c)
    local buttons = {
        awful.button({}, 1, function()
            c:activate({ context = "titlebar", action = "mouse_move" })
        end),
        awful.button({}, 2, function()
            c:kill()
        end),
        awful.button({}, 3, function()
            c:activate({ context = "titlebar", action = "mouse_resize" })
        end),
    }

    awful.titlebar(c, {
        size = beautiful.wibar_height,
    }).widget = {
        {
            { -- Left
                -- awful.titlebar.widget.iconwidget(c),
                {
                    image = utils.get_icon_client(c),
                    widget = wibox.widget.imagebox,
                },
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                {
                    halign = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                left = dpi(6) * 2,
                right = dpi(6) * 2,
                buttons = buttons,
                widget = wibox.container.margin,
            },
            { -- Right
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                spacing = dpi(6),
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    }
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ keys.super }, "b", function(c)
            awful.titlebar.toggle(c)
        end, { description = "Toggle titlebar", group = "client" }),
    })
end)
