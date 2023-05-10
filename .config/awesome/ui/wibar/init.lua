local awful = require("awful")
local wibox = require("wibox")

local tasklist = require("ui.wibar.tasklist")
local taglist = require("ui.wibar.taglist")
local launcher = require("ui.wibar.launcher")
local layoutlist = require("ui.wibar.layoutlist")
local textclock = require("ui.wibar.textclock")
local systray = require("ui.wibar.systray")
local player = require("ui.wibar.player")
local prompt = require("ui.wibar.prompt")

screen.connect_signal("request::desktop_decoration", function(s)
    s.wibox = awful.wibar({
        position = "top",
        -- height = 24,
        screen = s,
        widget = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                launcher,
                taglist(s),
                prompt,
            },
            { -- Middle widget
                layout = wibox.layout.fixed.horizontal,
                tasklist(s),
                player,
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                systray,
                textclock,
                layoutlist,
            },
        },
    })
end)
