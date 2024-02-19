local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local tasklist = require("ui.wibar.tasklist")
local taglist = require("ui.wibar.taglist")
local layoutlist = require("ui.wibar.layoutlist")

local launcher = require("ui.wibar.launcher")
local clock = require("ui.wibar.clock")
local systray = require("ui.wibar.systray")
local prompt = require("ui.wibar.prompt")
local playerbox = require("ui.wibar.playerbox")
local volume = require("ui.wibar.volume")
local mic = require("ui.wibar.mic")
local cpu = require("ui.wibar.cpu")
local memory = require("ui.wibar.memory")
local gpu = require("ui.wibar.gpu")
-- local net = require("ui.wibar.net")
-- local thermal = require("ui.wibar.thermal")
-- local fs = require("ui.wibar.fs")

screen.connect_signal("request::desktop_decoration", function(s)
    local is_primary = s == screen.primary

    s.wibox = awful.wibar({
        -- visible = false,
        position = "top",
        screen = s,
        widget = {
            { -- Left
                is_primary and launcher,
                taglist(s),
                layoutlist(s),
                is_primary and systray,
                tasklist(s),
                is_primary and prompt,
                layout = wibox.layout.fixed.horizontal,
            },
            is_primary and { -- Middle
                {
                    playerbox,
                    left = dpi(6) * 4,
                    right = dpi(6) * 4,
                    widget = wibox.container.margin,
                },
                content_fill_vertical = true,
                widget = wibox.container.place,
            },
            is_primary and { -- Right
                -- net,
                -- fs,
                -- thermal,
                gpu,
                memory,
                cpu,
                volume,
                mic,
                clock,
                spacing = dpi(6) * 2,
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
    })
end)
