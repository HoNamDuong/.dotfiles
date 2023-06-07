local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local pango = require("utils").pango

local mic = wibox.widget({
    {
        id = "mic_icon",
        image = beautiful.mic_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "mic_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
    set_mic = function(self, val)
        if string.match(val, "muted") then
            self.mic_text.markup = pango.span({ foreground = beautiful.palette.yellow, "off" })
            self:get_children_by_id("mic_icon")[1].image = beautiful.mic_off_icon
        else
            self.mic_text.markup = val
            self:get_children_by_id("mic_icon")[1].image = beautiful.mic_icon
        end
    end,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn("pamixer --default-source --toggle-mute")
        end),
        -- awful.button({}, 3, function() end),
        awful.button({}, 4, function()
            awful.spawn("pamixer --default-source --increase" .. " " .. "5")
        end),
        awful.button({}, 5, function()
            awful.spawn("pamixer --default-source --decrease" .. " " .. "5")
        end),
    },
})

gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async({ "sh", "-c", "pamixer --default-source --get-volume-human" }, function(out)
            mic.mic = string.gsub(out, "%\n", "")
        end)
    end,
})

return mic
