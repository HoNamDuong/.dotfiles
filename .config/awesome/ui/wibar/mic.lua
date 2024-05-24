local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local pango = require("utils").pango

local mic = wibox.widget({
    {
        {
            {
                id = "mic_icon_role",
                image = beautiful.mic_icon,
                resize = true,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                id = "mic_text_role",
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
        local value, muted = string.match(out, "^(.-)\n(.-)\n$")
        if muted == "yes" then
            mic:get_children_by_id("mic_text_role")[1].markup = pango.span({ "muted", foreground = beautiful.colors.medium })
            mic:get_children_by_id("mic_icon_role")[1].image = beautiful.mic_mute_icon
        else
            mic:get_children_by_id("mic_text_role")[1].markup = value
            mic:get_children_by_id("mic_icon_role")[1].image = beautiful.mic_icon
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
                awesome.emit_signal("mic::changed")
            end,
        })
    else
        mic.visible = false
    end
end)

return mic
