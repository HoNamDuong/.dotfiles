local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local keys = require("config").keys

local cols_size = dpi(6) * 10 * 2
local rows_size = dpi(6) * 10 * 2

local function box_widget(widgets, width, height)
    return wibox.widget({
        widgets,
        forced_width = width,
        forced_height = height,
        -- border_width = beautiful.border_width,
        -- border_color = beautiful.common.secondary,
        widget = wibox.container.background,
    })
end

local clock_widget = require("ui.dashboard.clock")
local clock = box_widget(clock_widget, cols_size * 2, rows_size * 1)

local calendar_widget = require("ui.dashboard.calendar")
local calendar = box_widget(calendar_widget, cols_size * 2, rows_size * 2)

local countdown_widget = require("ui.dashboard.countdown")
local countdown = box_widget(countdown_widget, cols_size * 2, rows_size * 1)

local powermenu_widget = require("ui.dashboard.powermenu")
local powermenu = box_widget(powermenu_widget, cols_size * 1, rows_size * 4)

local notifications_widget = require("ui.dashboard.notifications")
local notifications = box_widget(notifications_widget, cols_size * 3, rows_size * 4)

local workarea = screen.primary.workarea

local dashboard = wibox({
    widget = {
        {
            {
                clock,
                calendar,
                countdown,
                layout = wibox.layout.fixed.vertical,
            },
            powermenu,
            layout = wibox.layout.fixed.horizontal,
        },
        notifications_widget,
        nil,
        layout = wibox.layout.align.vertical,
    },
    type = "dock",
    screen = screen.primary,
    visible = false,
    ontop = true,
    width = cols_size * 3.,
    height = workarea.height - (beautiful.useless_gap * 4) - (beautiful.border_width * 2) - beautiful.wibar_height,
    border_width = beautiful.border_width,
    border_color = beautiful.common.secondary,
})

awful.placement.bottom_left(dashboard, {
    margins = beautiful.useless_gap * 2,
})

function dashboard:toggle()
    self.visible = not self.visible
end

awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "d", function()
        dashboard:toggle()
    end, { description = "Toggle dashboard", group = "actions" }),
})

return dashboard
