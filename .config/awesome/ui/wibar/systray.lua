local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local systray = wibox.container.margin(wibox.widget.systray(), dpi(6), dpi(6), dpi(2), dpi(2), beautiful.bg_systray)

return systray
