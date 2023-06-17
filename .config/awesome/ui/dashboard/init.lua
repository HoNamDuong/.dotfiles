local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

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

local dashboard = awful.popup({
    widget = {
        homogeneous = true,
        superpose = false,
        forced_num_cols = 6,
        forced_num_rows = 4,
        layout = wibox.layout.grid,
    },
    type = "toolbar",
    border_width = beautiful.border_width,
    border_color = beautiful.common.secondary,
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

dashboard.widget:add_widget_at(clock, 1, 1, 1, 2)
dashboard.widget:add_widget_at(calendar, 2, 1, 2, 2)
dashboard.widget:add_widget_at(countdown, 4, 1, 1, 2)
dashboard.widget:add_widget_at(powermenu, 1, 3, 4, 1)
dashboard.widget:add_widget_at(notifications, 1, 4, 4, 3)

local grabber = function(_, key, event)
    if event == "press" then
        if key == "Escape" then
            dashboard:hide()
        end
    end
end

function dashboard:show()
    awful.keygrabber.run(grabber)
    self.visible = true
end

function dashboard:hide()
    awful.keygrabber.stop(grabber)
    self.visible = false
end

function dashboard:toggle()
    if self.visible then
        self:hide()
    else
        self:show()
    end
end

return dashboard
