local awful = require("awful")
local wibox = require("wibox")

local tasklist = function(s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
            awful.button({}, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
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
        --         forced_height = 2,
        --         id = "background_role",
        --         widget = wibox.container.background,
        --     },
        --     {
        --         awful.widget.clienticon,
        --         top = 0,
        --         bottom = 2,
        --         left = 3,
        --         right = 3,
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
                    margins = 2,
                    widget = wibox.container.margin,
                },
                left = 2,
                right = 2,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

return tasklist
