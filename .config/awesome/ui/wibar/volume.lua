local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local pango = require("utils").pango

local volume = wibox.widget({
    {
        {
            {
                id = "volume_icon_role",
                image = beautiful.volume_icon,
                resize = true,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                id = "volume_text_role",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    bg = beautiful.colors.background,
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            awesome.emit_signal("volume::changed")
        end),
        awful.button({}, 4, function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
            awesome.emit_signal("volume::changed")
        end),
        awful.button({}, 5, function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
            awesome.emit_signal("volume::changed")
        end),
    },
})

awesome.connect_signal("volume::changed", function()
    awful.spawn.easy_async({ "sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' && pactl get-sink-mute @DEFAULT_SINK@ | awk 'NR==1{print $2}'" }, function(out)
        local value, muted = string.match(out, "^(.-)\n(.-)\n$")
        if muted == "yes" then
            volume:get_children_by_id("volume_text_role")[1].markup = pango.span({ "muted", foreground = beautiful.colors.medium })
            volume:get_children_by_id("volume_icon_role")[1].image = beautiful.volume_mute_icon
        else
            volume:get_children_by_id("volume_text_role")[1].markup = value
            volume:get_children_by_id("volume_icon_role")[1].image = beautiful.volume_icon
        end
    end)
end)

awful.spawn.easy_async("which pactl", function(stdout, stderr, reason, exit_code)
    if exit_code == 0 then
        gears.timer({
            timeout = 5,
            call_now = true,
            autostart = true,
            callback = function()
                awesome.emit_signal("volume::changed")
            end,
        })
    else
        volume.visible = false
    end
end)

return volume
