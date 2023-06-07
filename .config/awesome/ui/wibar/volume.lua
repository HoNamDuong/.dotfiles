local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local pango = require("utils").pango

local volume = wibox.widget({
    {
        id = "volume_icon",
        image = beautiful.volume_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "volume_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
    set_volume = function(self, val)
        if string.match(val, "muted") then
            self.volume_text.markup = pango.span({ val, foreground = beautiful.palette.yellow })
            self:get_children_by_id("volume_icon")[1].image = beautiful.volume_mute_icon
        else
            self.volume_text.markup = val
            self:get_children_by_id("volume_icon")[1].image = beautiful.volume_icon
        end
    end,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn("pamixer --toggle-mute")
        end),
        -- awful.button({}, 3, function() end),
        awful.button({}, 4, function()
            awful.spawn("pamixer --increase" .. " " .. "5")
        end),
        awful.button({}, 5, function()
            awful.spawn("pamixer --decrease" .. " " .. "5")
        end),
    },
})

gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async({ "sh", "-c", "pamixer --get-volume-human" }, function(out)
            volume.volume = string.gsub(out, "%\n", "")
        end)
    end,
})

return volume
