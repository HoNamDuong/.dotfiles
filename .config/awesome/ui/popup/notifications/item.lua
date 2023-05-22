local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi
local recolor_image = require("gears.color").recolor_image

local item = {}

function item.notification_item(n)
    -- urgency color
    local urgency_color = beautiful.palette.secondary
    if n.urgency == "normal" then
        urgency_color = beautiful.palette.primary
    elseif n.urgency == "critical" then
        urgency_color = beautiful.palette.urgent
    end

    -- app name
    local app_name_n = wibox.widget({
        markup = n.app_name == "" and "Notification" or n.app_name,
        valign = "center",
        widget = wibox.widget.textbox,
    })

    -- time
    local time_n = wibox.widget({
        {
            markup = os.date("%H:%M:%S"),
            halign = "right",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        margins = { left = dpi(6) },
        widget = wibox.container.margin,
    })

    -- image
    local image_n = wibox.widget({
        {
            image = n.icon and n.icon or recolor_image(beautiful.notification_icon, urgency_color),
            resize = true,
            halign = "center",
            -- valign = "center",
            widget = wibox.widget.imagebox,
        },
        strategy = "exact",
        height = dpi(64),
        width = dpi(64),
        widget = wibox.container.constraint,
    })

    -- title
    local title_n = wibox.widget({
        {
            markup = n.title,
            align = "left",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        speed = 50,
        step_function = wibox.container.scroll.step_functions.nonlinear_back_and_forth,
        widget = wibox.container.scroll.horizontal,
    })

    -- message
    local message_n = wibox.widget({
        {
            markup = "<span weight='normal'>" .. n.message .. "</span>",
            -- font = "Roboto Medium 11",
            align = "left",
            valign = "center",
            wrap = "char",
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
    })

    -- actions
    local actions_n = wibox.widget({
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

    return {
        {
            {
                {
                    {
                        app_name_n,
                        time_n,
                        {
                            id = "layout_role",
                            layout = wibox.layout.fixed.horizontal,
                        },
                        layout = wibox.layout.align.horizontal,
                    },
                    {
                        {
                            image_n,
                            {
                                title_n,
                                message_n,
                                spacing = dpi(6),
                                layout = wibox.layout.fixed.vertical,
                            },
                            spacing = dpi(12),
                            layout = wibox.layout.fixed.horizontal,
                        },
                        top = dpi(12),
                        bottom = dpi(12),
                        widget = wibox.container.margin,
                    },
                    actions_n,
                    layout = wibox.layout.fixed.vertical,
                },
                margins = beautiful.useless_gap * 2,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        },
        border_width = beautiful.border_width,
        border_color = urgency_color,
        widget = wibox.container.background,
    }
end

function item.delete_button(widget, notif_list)
    return {
        {
            image = beautiful.bin_icon,
            resize = true,
            forced_width = dpi(18),
            forced_height = dpi(18),
            widget = wibox.widget.imagebox,
        },
        left = dpi(6),
        widget = wibox.container.margin,
        buttons = {
            awful.button({}, 1, function()
                notif_list:remove_widgets(widget)
                awesome.emit_signal("notifications::message", "Notification removed successfully")
            end),
        },
    }
end

return item
