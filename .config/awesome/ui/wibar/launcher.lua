local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local mainmenu = require("ui.menu.mainmenu")
local dashboard = require("ui.popup.dashboard")

local launcher = awful.widget.button({
    image = beautiful.dashboard_icon,
    widget = wibox.widget.imagebox,
    buttons = {
        awful.button({}, 1, nil, function()
            awesome.emit_signal("notifications::toggle")
            -- dashboard:toggle()
        end),
        awful.button({}, 3, nil, function()
            mainmenu:toggle()
        end),
    },
})

-- launcher:connect_signal("mouse::enter", function()
--     launcher.opacity = 0.6
-- end)
-- launcher:connect_signal("mouse::leave", function()
--     launcher.opacity = 1
-- end)

return launcher
