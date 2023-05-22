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
-- local volume = require("ui.wibar.volume")

screen.connect_signal("request::desktop_decoration", function(s)
    s.wibox = awful.wibar({
        position = "top",
        screen = s,
        widget = {
            layout = wibox.layout.align.horizontal,
            { -- Left
                launcher,
                prompt,
                taglist(s),
                systray,
                tasklist(s),
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                player,
                layout = wibox.layout.flex.horizontal,
            },
            { -- Right
                -- volume,
                textclock,
                layoutlist,
                layout = wibox.layout.fixed.horizontal,
            },
        },
    })
end)
