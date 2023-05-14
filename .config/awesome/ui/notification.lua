local ruled = require("ruled")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Notification
ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "low" },
        properties = {
            implicit_timeout = 5,
            border_color = beautiful.palette.secondary,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "normal" },
        properties = {
            implicit_timeout = 20,
            border_color = beautiful.palette.primary,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "critical" },
        properties = {
            never_timeout = true,
            border_color = beautiful.palette.urgent,
        },
    })
end)

naughty.connect_signal("request::display", function(n)
    local app_name = "Notification"
    if n.app_name ~= "" then
        app_name = n.app_name
    end

    local actions = wibox.widget({
        notification = n,
        base_layout = wibox.widget({
            spacing = dpi(6),
            layout = wibox.layout.flex.horizontal,
        }),
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                        },
                        forced_height = dpi(32),
                        layout = wibox.layout.fixed.horizontal,
                    },
                    widget = wibox.container.place,
                },
                strategy = "min",
                width = dpi(100),
                widget = wibox.container.constraint,
            },
            bg = beautiful.palette.secondary,
            widget = wibox.container.background,
        },
        style = {
            underline_normal = false,
            underline_selected = true,
        },
        widget = naughty.list.actions,
    })

    naughty.layout.box({
        type = "notification",
        notification = n,
        widget_template = {
            {
                {
                    {
                        {
                            {
                                markup = "<b>" .. app_name .. "</b>",
                                halign = "center",
                                valign = "center",
                                widget = wibox.widget.textbox,
                            },
                            {
                                {
                                    naughty.widget.icon,
                                    {
                                        naughty.widget.title,
                                        naughty.widget.message,
                                        spacing = dpi(6),
                                        layout = wibox.layout.fixed.vertical,
                                    },
                                    fill_space = true,
                                    spacing = dpi(12),
                                    layout = wibox.layout.fixed.horizontal,
                                },
                                top = dpi(12),
                                bottom = dpi(12),
                                widget = wibox.container.margin,
                            },
                            actions,
                            layout = wibox.layout.fixed.vertical,
                        },
                        margins = dpi(12),
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = naughty.container.background,
                },
                strategy = "min",
                width = dpi(150),
                widget = wibox.container.constraint,
            },
            strategy = "max",
            width = dpi(300),
            widget = wibox.container.constraint,
        },
    })
end)

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
