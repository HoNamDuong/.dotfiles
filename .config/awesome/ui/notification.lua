local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local recolor_image = require("gears.color").recolor_image

naughty.notification_list = wibox.widget({
    spacing = beautiful.useless_gap * 2,
    layout = wibox.layout.fixed.vertical,
})

local pointer = 0
local min_widgets = 3

naughty.notification_list:connect_signal("button::press", function(_, _, _, button)
    if button == 5 then -- up scrolling
        if pointer < #naughty.notification_list.children and ((#naughty.notification_list.children - pointer) >= min_widgets) then
            pointer = pointer + 1
            naughty.notification_list.children[pointer].visible = false
        end
    elseif button == 4 then -- down scrolling
        if pointer > 0 then
            naughty.notification_list.children[pointer].visible = true
            pointer = pointer - 1
        end
    end
end)

local function notification_item(n)
    -- urgency color
    local urgency_color = beautiful.common.secondary
    if n.urgency == "normal" then
        urgency_color = beautiful.common.primary
    elseif n.urgency == "critical" then
        urgency_color = beautiful.common.high
    end

    -- app name
    local app_name_n = wibox.widget({
        markup = n.app_name == "" and "Notification" or n.app_name,
        valign = "center",
        widget = wibox.widget.textbox,
    })

    -- time
    local time_n = wibox.widget({
        markup = os.date(" %H:%M:%S "),
        halign = "right",
        valign = "center",
        widget = wibox.widget.textbox,
    })

    -- image
    local image_n = wibox.widget({
        image = n.icon and n.icon or recolor_image(beautiful.notification_icon, urgency_color),
        resize = true,
        halign = "center",
        -- valign = "center",
        forced_width = dpi(6) * 10,
        forced_height = dpi(6) * 10,
        widget = wibox.widget.imagebox,
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
            markup = n.message,
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
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    margins = dpi(6),
                    widget = wibox.container.margin,
                },
                widget = wibox.container.place,
            },
            bg = beautiful.common.secondary,
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
                    app_name_n,
                    time_n,
                    nil,
                    id = "header_rule",
                    layout = wibox.layout.align.horizontal,
                },
                {
                    image_n,
                    {
                        title_n,
                        message_n,
                        spacing = dpi(6),
                        layout = wibox.layout.fixed.vertical,
                    },
                    spacing = dpi(6) * 2,
                    layout = wibox.layout.fixed.horizontal,
                },
                actions_n,
                spacing = dpi(6) * 2,
                layout = wibox.layout.fixed.vertical,
            },
            margins = dpi(6) * 2,
            widget = wibox.container.margin,
        },
        border_width = beautiful.border_width,
        border_color = urgency_color,
        widget = wibox.container.background,
    }
end

local function delete_button(widget)
    return {
        image = beautiful.bin_icon,
        resize = true,
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
        buttons = {
            awful.button({}, 1, function()
                naughty.notification_list:remove_widgets(widget)
            end),
        },
    }
end

-- Default
naughty.connect_signal("request::display", function(n)
    -- template
    local widget_template = notification_item(n)

    -- popup
    naughty.layout.box({
        type = "notification",
        notification = n,
        border_width = dpi(0),
        minimum_width = dpi(6) * 10 * 6,
        maximum_width = dpi(6) * 10 * 6,
        widget_template = widget_template,
    })

    -- widget
    local widget = wibox.widget(widget_template)
    widget:get_children_by_id("header_rule")[1].third = wibox.widget(delete_button(widget))

    naughty.notification_list:insert(1, widget)
end)

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
