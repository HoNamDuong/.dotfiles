local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local utils = require("utils")

local tasklist = function(s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
            awful.button({}, 2, function(c)
                c:kill()
            end),
            awful.button({}, 3, function(c)
                awesome.emit_signal("clientmenu::toggle", c)
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
        --         left = dpi(6),
        --         right = dpi(6),
        --         widget = wibox.container.margin,
        --     },
        --     layout = wibox.layout.align.vertical,
        -- },
        widget_template = {
            {
                {
                    id = "icon_client",
                    widget = wibox.widget.imagebox,
                },
                top = dpi(2),
                bottom = dpi(2),
                left = dpi(6),
                right = dpi(6),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c, index, clients)
                self:get_children_by_id("icon_client")[1].image = utils.get_icon_client(c)
            end,
        },
    })
end

return tasklist
