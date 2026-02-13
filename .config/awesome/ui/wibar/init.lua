local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local tasklist = require("ui.wibar.tasklist")
local taglist = require("ui.wibar.taglist")
local layoutlist = require("ui.wibar.layoutlist")

local minimization = require("ui.wibar.minimization")
local dashboard = require("ui.wibar.dashboard")
local clock = require("ui.wibar.clock")
local systray = require("ui.wibar.systray")
local playerbox = require("ui.wibar.playerbox")
local volume = require("ui.wibar.volume")
local mic = require("ui.wibar.mic")
local cpu = require("ui.wibar.cpu")
local memory = require("ui.wibar.memory")
local gpu = require("ui.wibar.gpu")
-- local net = require("ui.wibar.net")

screen.connect_signal("request::desktop_decoration", function(s)
    local is_primary = s == screen.primary

    s.wibox = awful.wibar({
        -- visible = false,
        position = "top",
        screen = s,
        widget = {
            -- Left
            {
                is_primary and dashboard,
                taglist(s),
                is_primary and systray,
                tasklist(s),
                layout = wibox.layout.fixed.horizontal,
            },
            -- Middle
            {
                {
                    playerbox,
                    forced_width = dpi(6) * 50,
                    widget = wibox.container.place,
                },
                widget = wibox.container.place,
            },
            -- Right
            {
                -- is_primary and net,
                is_primary and gpu,
                is_primary and memory,
                is_primary and cpu,
                is_primary and volume,
                is_primary and mic,
                is_primary and clock,
                layoutlist(s),
                minimization,
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
    })
end)
