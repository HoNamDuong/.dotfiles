local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local function box_widget(widgets, width, height)
    return wibox.widget({
        widgets,
        forced_width = dpi(width),
        forced_height = dpi(height),
        -- border_width = beautiful.border_width,
        -- border_color = beautiful.border_focus,
        widget = wibox.container.background,
    })
end

local notifications_widget = require("ui.dashboard.notifications")
local notifications = box_widget(notifications_widget, dpi(360), dpi(600))

local powermenu_widget = require("ui.dashboard.powermenu")
local powermenu = box_widget(powermenu_widget, dpi(120), dpi(600))

local calendar_widget = require("ui.dashboard.calendar")
local calendar = box_widget(calendar_widget, dpi(240), dpi(240))

local clock_widget = require("ui.dashboard.clock")
local clock = box_widget(clock_widget, dpi(240), dpi(120))

local profile_widget = require("ui.dashboard.profile")
local profile = box_widget(profile_widget, dpi(240), dpi(120))

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
    -- spacing = beautiful.useless_gap * 2,
    min_cols_size = dpi(120),
    min_rows_size = dpi(120),
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
        text = "second",
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

-- local powermenu = wibox.widget({
--     {
--         text = "powermenu",
--         widget = wibox.widget.textbox,
--     },
--     border_width = beautiful.border_width,
--     border_color = beautiful.border_focus,
--     bg = beautiful.bg_normal,
--     widget = wibox.container.background,
-- })

dashboard.widget:add_widget_at(profile, 1, 1, 1, 2)
dashboard.widget:add_widget_at(clock, 3, 1, 1, 2)
dashboard.widget:add_widget_at(calendar, 4, 1, 2, 2)
dashboard.widget:add_widget_at(powermenu, 1, 3, 5, 1)
dashboard.widget:add_widget_at(notifications, 1, 4, 5, 3)

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
