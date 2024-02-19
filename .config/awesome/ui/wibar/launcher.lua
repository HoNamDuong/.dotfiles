local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local launcher = awful.widget.button({
    image = beautiful.dashboard_icon,
    widget = wibox.widget.imagebox,
    buttons = {
        awful.button({}, 1, nil, function()
            awesome.emit_signal("dashboard::toggle")
        end),
        awful.button({}, 3, nil, function()
            awesome.emit_signal("mainmenu::toggle")
        end),
    },
})

return launcher
