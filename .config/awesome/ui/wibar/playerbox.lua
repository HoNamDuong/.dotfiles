local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi
local icon_theme = require("menubar.icon_theme")
local recolor_image = require("gears.color").recolor_image
local apps = require("config").apps

local sel = 1

local empty_player = wibox.widget({
    markup = " No players found ",
    halign = "center",
    valign = "center",
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn(apps.music)
        end),
    },
})

local player_widget_list = wibox.widget({
    layout = wibox.layout.fixed.horizontal,
})

local function next_player()
    if #player_widget_list.children > 1 then
        local sel_new = sel + 1 > #player_widget_list.children and 1 or sel + 1
        player_widget_list.children[sel].visible = false
        player_widget_list.children[sel_new].visible = true
        sel = sel_new
    end
end

local playerbox = wibox.widget({
    {
        {
            id = "player_role",
            {
                image = recolor_image(beautiful.arrow_down_icon, beautiful.common.foreground),
                visible = false,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
                buttons = {
                    awful.button({}, 1, function()
                        next_player()
                    end),
                },
            },
            empty_player,
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    bg = beautiful.common.secondary_dark,
    widget = wibox.container.background,
})

player_widget_list:connect_signal("widget::layout_changed", function()
    sel = 1

    if #player_widget_list.children == 0 then
        playerbox:get_children_by_id("player_role")[1]:set(2, empty_player)
    else
        playerbox:get_children_by_id("player_role")[1]:set(2, player_widget_list)

        for i = 1, #player_widget_list.children, 1 do
            player_widget_list.children[i].visible = false
        end

        player_widget_list.children[sel].visible = true

        if #player_widget_list.children > 1 then
            playerbox:get_children_by_id("player_role")[1].children[1].visible = true
        else
            playerbox:get_children_by_id("player_role")[1].children[1].visible = false
        end
    end
end)

local function build_player_widget(player)
    local widget = wibox.widget({
        {
            image = beautiful.previous_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    player:previous()
                end),
            },
        },
        {
            id = "player_control",
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    player:play_pause()
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
                    player:next()
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
            id = "player_metadata",
            halign = "center",
            valign = "center",
            widget = wibox.widget.textbox,
            buttons = {
                awful.button({}, 1, function()
                    player:play_pause()
                end),
            },
        },
        visible = false,
        spacing = dpi(6),
        layout = wibox.layout.fixed.horizontal,
    })

    local function get_control_icon(status)
        local icon = nil
        if status == "PLAYING" then
            icon = beautiful.pause_icon
        elseif status == "PAUSED" then
            icon = beautiful.play_icon
        else
            icon = beautiful.stop_icon
            next_player()
        end
        return icon
    end

    local function initial()
        widget:get_children_by_id("player_control")[1].image = get_control_icon(player.playback_status)
        widget:get_children_by_id("player_icon")[1].image = icon_theme():find_icon_path(player.player_name)
        awful.spawn.easy_async("playerctl " .. "--player=" .. player.player_instance .. " metadata --format '{{artist}}\n{{title}}'", function(stdout)
            stdout = pango.escape(stdout)
            local artist, title = string.match(stdout, "^(.-)%\n(.-)$")

            widget:get_children_by_id("player_metadata")[1].markup = " " .. pango.b(artist or "") .. " - " .. (title or "")
        end)
    end
    initial()

    player.on_playback_status = function()
        widget:get_children_by_id("player_control")[1].image = get_control_icon(player.playback_status)
    end

    player.on_metadata = function()
        awful.spawn.easy_async(
            "playerctl " .. "--player=" .. player.player_instance .. " metadata --format '{{playerName}}\n{{status}}\n{{artist}}\n{{title}}\n{{mpris:trackid}}\n{{mpris:artUrl}}'",
            function(stdout)
                stdout = pango.escape(stdout)
                local player_name, status, artist, title, track_id, art_url = string.match(stdout, "^(.-)%\n(.-)%\n(.-)%\n(.-)%\n(.-)%\n(.-)$")

                widget:get_children_by_id("player_metadata")[1].markup = " " .. pango.b(artist or "") .. " - " .. (title or "")
            end
        )
    end

    return widget
end

gears.timer.delayed_call(function()
    local Playerctl = require("lgi").Playerctl

    local manager = Playerctl.PlayerManager()

    for _, name in ipairs(manager.player_names) do
        local player = Playerctl.Player.new_from_name(name)
        manager:manage_player(player)
    end

    for _, player in ipairs(manager.players) do
        local player_widget = build_player_widget(player)
        player_widget.id = player.player_instance
        player_widget_list:insert(1, player_widget)
    end

    function manager:on_name_appeared(name)
        local player = Playerctl.Player.new_from_name(name)
        manager:manage_player(player)
    end

    function manager:on_player_appeared(player)
        local player_widget = build_player_widget(player)
        player_widget.id = player.player_instance
        player_widget_list:insert(1, player_widget)
    end

    function manager:on_name_vanished(name)
        -- naughty.notification({
        --     message = #player_widget_list,
        -- })
    end

    function manager:on_player_vanished(player)
        local function find_index(array, id)
            for index, value in ipairs(array) do
                if value.id == id then
                    return index
                end
            end
            return nil
        end
        local index = find_index(player_widget_list.children, player.player_instance)

        player_widget_list:remove(index)
    end
end)

return playerbox
