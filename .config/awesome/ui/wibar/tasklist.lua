local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi
local clientmenu = require("ui.clientmenu")
local cairo = require("lgi").cairo

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
                clientmenu:toggle(c)
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
                    id = "icon_role",
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
            create_callback = function(self, c, index, objects)
                if c and c.valid and not c.icon then
                    local s = gears.surface(beautiful.package_icon)
                    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
                    local cr = cairo.Context(img)
                    cr:set_source_surface(s, 0, 0)
                    cr:paint()
                    c.icon = img._native
                end
            end,
        },
    })
end

return tasklist
