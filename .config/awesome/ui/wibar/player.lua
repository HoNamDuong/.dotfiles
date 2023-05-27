local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local dpi = require("beautiful.xresources").apply_dpi

local play = utils.colorize_text("", beautiful.palette.primary)
local pause = utils.colorize_text("", beautiful.palette.urgent)
local stop = utils.colorize_text("", beautiful.palette.secondary)

-- local player_text = wibox.widget.textbox()
-- awful.spawn.with_line_callback("playerctl --follow metadata --format ' {{ uc(playerName) }} <{{status}}>{{ duration(position) }}:{{ duration(mpris:length) }} {{artist}} | {{title}}'", {
--     stdout = function(line)
--         player_text.text(line)
--     end,
-- })

local player_text = awful.widget.watch(
    -- "playerctl metadata --format '{{ uc(playerName) }} <<{{status}}>> {{ duration(position) }}/{{ duration(mpris:length) }} {{artist}} | {{title}}'",
    "playerctl metadata --format '{{ uc(playerName) }} <<{{status}}>> {{artist}} | {{title}}'",
    1,
    function(widget, stdout)
        widget:set_markup_silently(stdout:gsub("<<Playing>>", play):gsub("<<Paused>>", pause):gsub("<<Stopped>>", stop):gsub("<<.+>>", ""))
        -- widget.text = stdout:gsub("<<Playing>>", ""):gsub("<<Paused>>", ""):gsub("<<Stopped>>", ""):gsub("<<.+>>", "")
    end,
    wibox.widget({
        -- halign = "center",
        valign = "center",
        forced_width = dpi(480),
        widget = wibox.widget.textbox(),
    })
)

local player = wibox.widget({
    widget = wibox.widget({
        {
            player_text,
            left = beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2,
            widget = wibox.container.margin,
        },
        -- bg = beautiful.palette.secondary .. "50",
        widget = wibox.container.background,
    }),
    buttons = {
        awful.button({}, 1, function()
            awful.spawn("playerctl previous")
        end),
        awful.button({}, 2, function()
            awful.spawn("playerctl play-pause")
        end),
        awful.button({}, 3, function()
            awful.spawn("playerctl next")
        end),
        -- awful.button({}, 4, function()
        --     awful.spawn(("playerctl position %f%s"):format(10, "+"))
        -- end),
        -- awful.button({}, 5, function()
        --     awful.spawn(("playerctl position %f%s"):format(10, "-"))
        -- end),
    },
})

return player
