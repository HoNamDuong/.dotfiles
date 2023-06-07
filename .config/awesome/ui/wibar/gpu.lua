local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local gpu = wibox.widget({
    {
        id = "gpu_icon",
        image = beautiful.gpu_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "gpu_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
})

gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async({ "sh", "-c", "nvidia-smi --query-gpu=memory.used,temperature.gpu --format=csv,noheader" }, function(out)
            local used, temperature = string.match(out, "^(.-)%, (.-)$")

            local  text = used .. " " .. temperature .. "°C" 
            gpu:get_children_by_id("gpu_text")[1].text = string.gsub(text, "%\n", "")
        end)
    end,
})

return gpu
