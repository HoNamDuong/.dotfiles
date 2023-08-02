local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

client.connect_signal("request::titlebars", function(c)
    -- Buttons for the titlebar
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
        size = dpi(6) * 4,
    }).widget = {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Title
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
    }
end)
