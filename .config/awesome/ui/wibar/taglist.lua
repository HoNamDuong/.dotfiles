local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local taglist = function(s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({}, 1, function(t)
                t:view_only()
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            -- awful.button({}, 4, function(t)
            --     awful.tag.viewprev(t.screen)
            -- end),
            -- awful.button({}, 5, function(t)
            --     awful.tag.viewnext(t.screen)
            -- end),
        },
        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    spacing = dpi(6),
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(2),
                bottom = dpi(2),
                left = dpi(6),
                right = dpi(6),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

return taglist
