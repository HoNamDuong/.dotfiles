local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local gpu = wibox.widget({
    {
        {
            id = "gpu_icon",
            image = beautiful.gpu_icon,
            resize = true,
            halign = "center",
            widget = wibox.widget.imagebox,
        },
        margins = {
            left = dpi(6),
            right = dpi(6),
            top = dpi(3),
            bottom = dpi(3),
        },
        widget = wibox.container.margin,
    },
    {
        id = "gpu_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
})

gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async({ "sh", "-c", "nvidia-smi --query-gpu=temperature.gpu,memory.used --format=csv,noheader" }, function(out)
            gpu:get_children_by_id("gpu_text")[1].text = out:gsub(",", "°C")
        end)
    end,
})

return gpu
