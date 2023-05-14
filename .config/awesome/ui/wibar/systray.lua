local wibox = require("wibox")
local beautiful = require("beautiful")

local systray = wibox.container.margin(wibox.widget.systray(), 6, 6, 2, 2, beautiful.bg_systray)

return systray
