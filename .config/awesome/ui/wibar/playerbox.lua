local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi
local icon_theme = require("menubar.icon_theme")
local recolor_image = require("gears.color").recolor_image
local Playerctl = require("lgi").Playerctl
local apps = require("config").apps

local player_widget_list = {}

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

local player_current = wibox.widget({
    empty_player,
    layout = wibox.layout.fixed.horizontal,
})

local function next_player()
    local sel_new = sel + 1 > #player_widget_list and 1 or sel + 1
    player_current:set(1, player_widget_list[sel_new])
    sel = sel_new
end

local next_button = wibox.widget({
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
})

local playerbox = wibox.widget({
    {
        {
            next_button,
            player_current,
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
        widget.id = player.player_instance
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

local function init_player(name, manager)
    local player = Playerctl.Player.new_from_name(name)
    manager:manage_player(player)
end

gears.timer.delayed_call(function()
    local manager = Playerctl.PlayerManager()

    for _, name in ipairs(manager.player_names) do
        init_player(name, manager)
    end

    for _, player in ipairs(manager.players) do
        local player_widget = build_player_widget(player)

        table.insert(player_widget_list, 1, player_widget)
        awesome.emit_signal("player_widget_list::changed")
    end

    function manager:on_name_appeared(name)
        init_player(name, manager)
    end

    function manager:on_player_appeared(player)
        local player_widget = build_player_widget(player)

        table.insert(player_widget_list, 1, player_widget)
        awesome.emit_signal("player_widget_list::changed")
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

        local index = find_index(player_widget_list, player.player_instance)

        table.remove(player_widget_list, index)
        awesome.emit_signal("player_widget_list::changed")
    end
end)

awesome.connect_signal("player_widget_list::changed", function()
    sel = 1

    if #player_widget_list == 0 then
        player_current:set(1, empty_player)
    else
        player_current:set(1, player_widget_list[1])

        if #player_widget_list > 1 then
            next_button.visible = true
        else
            next_button.visible = false
        end
    end
end)

return playerbox
