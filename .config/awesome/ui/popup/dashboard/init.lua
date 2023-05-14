local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local function box_widget(widgets, width, height)
    return wibox.widget({
        {
            {
                widgets,
                margins = dpi(6),
                widget = wibox.container.margin,
            },
            forced_width = dpi(width),
            forced_height = dpi(height),
            widget = wibox.container.background,
        },
        margins = { left = dpi(12), right = dpi(12) },
        widget = wibox.container.margin,
    })
end

-- local profile_widget = require("ui.dashboard.profile")
-- local profile = box_widget(profile_widget, 380, 150)

local dashboard = wibox({
    type = "toolbar",
    border_width = 2,
    border_color = beautiful.palette.secondary,
    ontop = true,
    width = dpi(300),
    height = dpi(600),
    visible = false,
})

awful.placement.left(dashboard, {
    honor_workarea = true,
    margins = beautiful.useless_gap * 2,
})

dashboard:setup({
    {
        -- profile,
        spacing = dpi(6),
        layout = wibox.layout.fixed.vertical,
    },
    margins = { top = dpi(24), bottom = dpi(24) },
    widget = wibox.container.margin,
})

function dashboard:toggle()
    self.visible = not self.visible
    return self.visible
end

return dashboard
