local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi
local pango = require("utils").pango

local mic = wibox.widget({
    {
        id = "icon_role",
        image = beautiful.mic_icon,
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
            self["text_role"].markup = pango.span({ foreground = beautiful.common.medium, val })
            self:get_children_by_id("icon_role")[1].image = beautiful.mic_off_icon
        else
            self["text_role"].markup = val
            self:get_children_by_id("icon_role")[1].image = beautiful.mic_icon
        end
    end,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
            awesome.emit_signal("mic::changed")
        end),
        awful.button({}, 4, function()
            awful.spawn("pactl set-source-volume @DEFAULT_SOURCE@ +5%")
            awesome.emit_signal("mic::changed")
        end),
        awful.button({}, 5, function()
            awful.spawn("pactl set-source-volume @DEFAULT_SOURCE@ -5%")
            awesome.emit_signal("mic::changed")
        end),
    },
})

awesome.connect_signal("mic::changed", function()
    awful.spawn.easy_async({ "sh", "-c", "pactl get-source-volume @DEFAULT_SOURCE@ | awk 'NR==1{print $5}' && pactl get-source-mute @DEFAULT_SOURCE@ | awk 'NR==1{print $2}'" }, function(out)
        local value, muted = string.match(out, "^(.-)\n(.-)$")
        if muted == "yes\n" then
            mic.value = string.gsub("muted", "%\n", "")
        else
            mic.value = string.gsub(value, "%\n", "")
        end
    end)
end)

awful.spawn.easy_async("which pactl", function(stdout, stderr, reason, exit_code)
    if exit_code == 0 then
        gears.timer({
            timeout = 5,
            autostart = true,
            callback = function()
                awesome.emit_signal("mic::changed")
            end,
        })
    end
end)

return mic
