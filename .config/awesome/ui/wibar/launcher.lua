local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local mainmenu = require("ui.mainmenu")
local dashboard = require("ui.dashboard")

local launcher = awful.widget.button({
    image = beautiful.dashboard_icon,
    widget = wibox.widget.imagebox,
    buttons = {
        awful.button({}, 1, nil, function()
            dashboard:toggle()
        end),
        awful.button({}, 3, nil, function()
            mainmenu:toggle()
        end),
    },
})

return launcher
