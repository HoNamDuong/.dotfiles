local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local recolor_image = require("gears.color").recolor_image

local pango = require("utils").pango

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
    local urgency_header_fg = beautiful.colors.foreground
    local urgency_header_bg = beautiful.colors.secondary
    local urgency_body_bg = beautiful.colors.secondary_dark
    local urgency_button_bg = beautiful.colors.secondary_dull
    if n.urgency == "normal" then
        urgency_header_fg = beautiful.colors.background
        urgency_header_bg = beautiful.colors.primary
        urgency_body_bg = beautiful.colors.primary_dark
        urgency_button_bg = beautiful.colors.primary_dull
    elseif n.urgency == "critical" then
        urgency_header_fg = beautiful.colors.background
        urgency_header_bg = beautiful.colors.high
        urgency_body_bg = beautiful.colors.high_dark
        urgency_button_bg = beautiful.colors.high_dull
    end

    -- app name
    local app_name_n = wibox.widget({
        markup = pango.b(n.app_name == "" and "Notification" or n.app_name),
        valign = "center",
        widget = wibox.widget.textbox,
    })

    -- time
    local time_n = wibox.widget({
        markup = pango.b(os.date("%H:%M:%S ")),
        valign = "center",
        widget = wibox.widget.textbox,
    })

    -- image
    local image_n = wibox.widget({
        image = n.icon and n.icon or recolor_image(beautiful.notification_icon, urgency_header_bg),
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
            markup = pango.b(n.title),
            align = "left",
            valign = "center",
            widget = wibox.widget.textbox,
        },
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
        max_size = 300,
        widget = wibox.container.scroll.vertical,
    })

    -- actions
    local actions_n = wibox.widget({
        notification = n,
        base_layout = wibox.widget({
            spacing = dpi(6) * 2,
            layout = wibox.layout.flex.horizontal,
        }),
        style = {
            underline_normal = false,
            underline_selected = true,
        },
        widget = naughty.list.actions,
        widget_template = {
            {
                {
                    id = "text_role",
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                margins = dpi(6),
                widget = wibox.container.margin,
            },
            bg = urgency_button_bg,
            widget = wibox.container.background,
        },
    })

    return {
        {
            {
                {
                    {
                        time_n,
                        nil,
                        app_name_n,
                        id = "header_role",
                        layout = wibox.layout.align.horizontal,
                    },
                    top = dpi(6),
                    bottom = dpi(6),
                    left = dpi(6) * 2,
                    right = dpi(6) * 2,
                    widget = wibox.container.margin,
                },
                bg = urgency_header_bg,
                fg = urgency_header_fg,
                widget = wibox.container.background,
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
                    spacing = dpi(6) * 2,
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = dpi(6) * 2,
                widget = wibox.container.margin,
            },
            #n.actions ~= 0 and {
                actions_n,
                top = dpi(0),
                bottom = dpi(6) * 2,
                left = dpi(6) * 2,
                right = dpi(6) * 2,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        },
        border_width = beautiful.border_width,
        border_color = urgency_header_bg,
        bg = urgency_body_bg,
        widget = wibox.container.background,
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
    widget:get_children_by_id("header_role")[1].buttons = {
        awful.button({}, 1, function()
            naughty.notification_list:remove_widgets(widget)
        end),
    }

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
