local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local tasklist = require("ui.wibar.tasklist")
local taglist = require("ui.wibar.taglist")
local launcher = require("ui.wibar.launcher")
local layoutlist = require("ui.wibar.layoutlist")
local clock = require("ui.wibar.clock")
local systray = require("ui.wibar.systray")
local prompt = require("ui.wibar.prompt")
local player = require("ui.wibar.player")
local volume = require("ui.wibar.volume")
local mic = require("ui.wibar.mic")
local cpu = require("ui.wibar.cpu")
local memory = require("ui.wibar.memory")
local gpu = require("ui.wibar.gpu")
local countdown = require("ui.wibar.countdown")
-- local net = require("ui.wibar.net")
-- local thermal = require("ui.wibar.thermal")
-- local fs = require("ui.wibar.fs")

screen.connect_signal("request::desktop_decoration", function(s)
    s.wibox = awful.wibar({
        position = "top",
        screen = s,
        widget = {
            { -- Left
                launcher,
                taglist(s),
                systray,
                tasklist(s),
                prompt,
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                player,
                widget = wibox.container.place,
            },
            { -- Right
                countdown,
                -- thermal,
                -- net,
                -- fs,
                gpu,
                memory,
                cpu,
                volume,
                mic,
                clock,
                layoutlist,
                spacing = dpi(6) * 2,
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
    })
end)
