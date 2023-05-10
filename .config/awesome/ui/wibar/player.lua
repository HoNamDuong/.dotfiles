local awful = require("awful")
local wibox = require("wibox")

local player_text = wibox.widget.textbox()
awful.spawn.with_line_callback("playerctl --follow metadata --format ' {{ uc(playerName) }} <{{status}}>{{ duration(position) }}:{{ duration(mpris:length) }} {{artist}} | {{title}}'", {
    stdout = function(line)
        player_text:set_text(line:gsub("<Playing>", "  "):gsub("<.+>", "  "))
    end,
})

local player = wibox.widget({
    widget = player_text,
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
