local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local function box_widget(widgets, width, height)
    return wibox.widget({
        {
            widgets,
            margins = dpi(6),
            widget = wibox.container.margin,
        },
        forced_width = dpi(width),
        forced_height = dpi(height),
        border_width = beautiful.border_width,
        border_color = beautiful.border_focus,
        widget = wibox.container.background,
    })
end

local notifications_widget = require("ui.dashboard.notifications")
local notifications = box_widget(notifications_widget, 360, 720)

local dashboard = awful.popup({
    widget = {},
    type = "toolbar",
    border_width = beautiful.border_width,
    border_color = beautiful.palette.secondary,
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

dashboard:setup({
    homogeneous = true,
    superpose = false,
    spacing = beautiful.useless_gap * 2,
    min_cols_size = 120,
    min_rows_size = 120,
    layout = wibox.layout.grid,
})

local first = wibox.widget({
    {
        text = "first",
        widget = wibox.widget.textbox,
    },
    border_width = beautiful.border_width,
    border_color = beautiful.border_focus,
    widget = wibox.container.background,
})
local second = wibox.widget({
    {
        text = "first",
        widget = wibox.widget.textbox,
    },
    border_width = beautiful.border_width,
    border_color = beautiful.border_focus,
    widget = wibox.container.background,
})
local third = wibox.widget({
    {
        text = "first",
        widget = wibox.widget.textbox,
    },
    border_width = beautiful.border_width,
    border_color = beautiful.border_focus,
    bg = beautiful.bg_normal,
    widget = wibox.container.background,
})

-- dashboard.widget:add_widget_at(first, 1, 1, 1, 1)
-- dashboard.widget:add_widget_at(second, 1, 2, 1, 1)
-- dashboard.widget:add_widget_at(third, 4, 1, 3, 3)
dashboard.widget:add_widget_at(notifications, 1, 4, 6, 3)

function dashboard:toggle()
    self.visible = not self.visible
end

return dashboard
