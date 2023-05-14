local awful = require("awful")
local wibox = require("wibox")
local calendar = require("ui.popup.calendar")

local textclock = wibox.widget({
    buttons = {
        awful.button({}, 1, nil, function()
            calendar.month:toggle()
        end),
    },
    widget = wibox.widget.textclock(" %A %d/%m/%Y %H:%M "),
})

return textclock
