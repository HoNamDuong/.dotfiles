local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local pango = require("utils").pango

local volume = wibox.widget({
    {
        id = "icon_role",
        image = beautiful.volume_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text_role",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
    set_value = function(self, val)
        if string.match(val, "muted") then
            self["text_role"].markup = pango.span({ val, foreground = beautiful.common.medium })
            self:get_children_by_id("icon_role")[1].image = beautiful.volume_mute_icon
        else
            self["text_role"].markup = val
            self:get_children_by_id("icon_role")[1].image = beautiful.volume_icon
        end
    end,
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
        local value, muted = string.match(out, "^(.-)\n(.-)$")
        if muted == "yes\n" then
            volume.value = string.gsub("muted", "%\n", "")
        else
            volume.value = string.gsub(value, "%\n", "")
        end
    end)
end)

awful.spawn.easy_async("which pactl", function(stdout, stderr, reason, exit_code)
    if exit_code == 0 then
        gears.timer({
            timeout = 5,
            autostart = true,
            callback = function()
                awesome.emit_signal("volume::changed")
            end,
        })
    end
end)

return volume
