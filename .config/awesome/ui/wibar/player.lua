local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi
local icon_theme = require("menubar.icon_theme")

local track_id_current = ""

local save_image_async_curl = function(url, filepath, callback)
    awful.spawn.with_line_callback(string.format("curl -L -s %s -o %s", url, filepath), {
        exit = callback,
    })
end

local player = wibox.widget({
    {
        {
            {
                image = beautiful.previous_icon,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn("playerctl previous")
                    end),
                },
            },
            {
                id = "player_control_icon",
                image = beautiful.stop_icon,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn("playerctl play-pause")
                    end),
                },
            },
            {
                image = beautiful.next_icon,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        awful.spawn("playerctl next")
                    end),
                },
            },
            {
                id = "player_icon",
                resize = true,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                id = "player_art_url",
                resize = true,
                visible = false,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                -- {
                id = "player_text",
                valign = "center",
                widget = wibox.widget.textbox,
                -- },
                -- speed = 50,
                -- step_function = wibox.container.scroll.step_functions.nonlinear_back_and_forth,
                -- widget = wibox.container.scroll.horizontal,
            },
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    visible = false,
    forced_width = dpi(60) * 8,
    bg = beautiful.palette.secondary .. "80",
    widget = wibox.container.background,
})

-- awful.spawn.with_line_callback("playerctl --follow metadata --format '{{playerName}}|{{status}}|{{artist}}|{{title}}|{{mpris:trackid}}|{{mpris:artUrl}}'", {
--     stdout = function(line)
--         if line ~= "" then
--             player.visible = true
--
--             -- Get player info
--             local player_name, status, artist, title, track_id, art_url = string.match(line, "^(.-)%|(.-)%|(.-)%|(.-)%|(.-)%|(.-)$")
--
--             -- naughty.notification({
--             --     text = "|" .. player_name .. "|\n" .. "|" .. status .. "|\n" .. "|" .. artist .. "|\n" .. "|" .. title .. "|\n" .. "|" .. track_id .. "|\n" .. "|" .. art_url .. "|",
--             --     urgency = "low",
--             -- })
--
--             -- Player name
--             player:get_children_by_id("player_icon")[1].image = icon_theme():find_icon_path(player_name)
--
--             -- Player control icon
--             local icon = ""
--             if status == "Playing" then
--                 icon = beautiful.pause_icon
--             elseif status == "Paused" then
--                 icon = beautiful.play_icon
--             else
--                 icon = beautiful.stop_icon
--             end
--             player:get_children_by_id("player_control_icon")[1].image = icon
--
--             -- Player artist and title
--             player:get_children_by_id("player_text")[1].markup = " " .. pango.b(artist) .. " | " .. title
--
--             -- Player track id
--             if track_id_current ~= track_id then
--                 track_id_current = track_id
--
--                 art_url = string.gsub(art_url, "%\n", "")
--
--                 -- Player art url
--                 if art_url ~= "" then
--                     if player_name == "mpd" then
--                         player:get_children_by_id("player_art_url")[1].image = art_url:gsub("file://", "")
--                     else
--                         local art_path = os.tmpname()
--                         save_image_async_curl(art_url, art_path, function()
--                             player:get_children_by_id("player_art_url")[1].image = art_path
--                         end)
--                     end
--                     player:get_children_by_id("player_art_url")[1].visible = true
--                 else
--                     player:get_children_by_id("player_art_url")[1].visible = false
--                 end
--             end
--         else
--             player.visible = false
--         end
--     end,
-- })

gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async("playerctl metadata --format '{{playerName}}|{{status}}|{{artist}}|{{title}}'", function(stdout)
            if stdout ~= "" then
                player.visible = true

                -- Get player info
                local player_name, status, artist, title = string.match(stdout, "^(.-)%|(.-)%|(.-)%|(.-)$")

                -- Player name
                player:get_children_by_id("player_icon")[1].image = icon_theme():find_icon_path(player_name)

                -- Player control icon
                local icon = ""
                if status == "Playing" then
                    icon = beautiful.pause_icon
                elseif status == "Paused" then
                    icon = beautiful.play_icon
                else
                    icon = beautiful.stop_icon
                end
                player:get_children_by_id("player_control_icon")[1].image = icon

                -- Player artist and title
                player:get_children_by_id("player_text")[1].markup = " " .. pango.b(artist) .. " | " .. title
            else
                player.visible = false
            end
        end)
    end,
})

return player
