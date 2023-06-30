local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

local notifications = wibox.widget({
    {
        {
            {
                {
                    id = "header_role",
                    markup = pango.b("Notifications") .. " " .. #naughty.notification_list.children,
                    align = "center",
                    valign = "center",
                    font = beautiful.font_name .. " " .. 14,
                    widget = wibox.widget.textbox,
                },
                nil,
                {
                    {
                        {
                            markup = pango.b("Clear"),
                            align = "center",
                            valign = "center",
                            widget = wibox.widget.textbox,
                            buttons = {
                                awful.button({}, 1, function()
                                    naughty.notification_list:reset()
                                    naughty.destroy_all_notifications()
                                end),
                            },
                        },
                        right = dpi(6),
                        left = dpi(6),
                        widget = wibox.container.margin,
                    },
                    fg = beautiful.common.background,
                    bg = beautiful.common.high,
                    widget = wibox.container.background,
                },
                layout = wibox.layout.align.horizontal,
            },
            naughty.notification_list,
            spacing = dpi(6) * 2,
            layout = wibox.layout.fixed.vertical,
        },
        {
            id = "empty_role",
            {
                markup = pango.i("NO NEW\nNOTIFICATIONS"),
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            visible = true,
            widget = wibox.container.place,
        },
        nil,
        layout = wibox.layout.align.vertical,
    },
    margins = dpi(6) * 2,
    widget = wibox.container.margin,
})

naughty.notification_list:connect_signal("widget::layout_changed", function()
    notifications:get_children_by_id("header_role")[1].markup = pango.b("Notifications") .. " " .. #naughty.notification_list.children
    if #naughty.notification_list.children == 0 then
        notifications:get_children_by_id("empty_role")[1].visible = true
    else
        notifications:get_children_by_id("empty_role")[1].visible = false
    end
end)

return notifications
