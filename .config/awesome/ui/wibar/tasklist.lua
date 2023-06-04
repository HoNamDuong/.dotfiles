local awful = require("awful")
local wibox = require("wibox")
-- local switcher = require("ui.switcher")
local dpi = require("beautiful.xresources").apply_dpi

local tasklist = function(s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
            awful.button({}, 3, function()
                -- switcher()
                awful.menu.client_list()
            end),
            -- awful.button({}, 4, function()
            --     awful.client.focus.byidx(-1)
            -- end),
            -- awful.button({}, 5, function()
            --     awful.client.focus.byidx(1)
            -- end),
        },
        layout = { layout = wibox.layout.fixed.horizontal },
        -- widget_template = {
        --     {
        --         id = "background_role",
        --         forced_height = dpi(2),
        --         widget = wibox.container.background,
        --     },
        --     {
        --         awful.widget.clienticon,
        --         top = dpi(0),
        --         bottom = dpi(2),
        --         left = dpi(3),
        --         right = dpi(3),
        --         widget = wibox.container.margin,
        --     },
        --     layout = wibox.layout.align.vertical,
        -- },
        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(2),
                    widget = wibox.container.margin,
                },
                left = dpi(2),
                right = dpi(2),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

return tasklist
