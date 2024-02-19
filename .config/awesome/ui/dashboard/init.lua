local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local keys = require("config").keys

local calendar_widget = require("ui.dashboard.calendar")
local clock_widget = require("ui.dashboard.clock")
local notifications_widget = require("ui.dashboard.notifications")

local workarea = screen.primary.workarea

local dashboard = wibox({
    widget = {
        {
            {
                {
                    calendar_widget,
                    clock_widget,
                    fill_space = true,
                    spacing = dpi(6) * 2,
                    layout = wibox.layout.fixed.horizontal,
                },
                bottom = dpi(6) * 2,
                widget = wibox.container.margin,
            },
            notifications_widget,
            nil,
            layout = wibox.layout.align.vertical,
        },
        margins = dpi(6) * 2,
        widget = wibox.container.margin,
    },
    type = "dock",
    screen = screen.primary,
    visible = false,
    ontop = true,
    width = dpi(6) * 10 * 7,
    height = workarea.height - (beautiful.useless_gap * 4) - (beautiful.border_width * 2),
    border_width = beautiful.border_width,
    border_color = beautiful.colors.secondary,
})

awful.placement.left(dashboard, {
    honor_workarea = true,
    margins = beautiful.useless_gap * 2,
})

awesome.connect_signal("dashboard::toggle", function()
    dashboard.visible = not dashboard.visible
end)

awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "d", function()
        awesome.emit_signal("dashboard::toggle")
    end, { description = "Toggle dashboard", group = "awesome" }),
})
