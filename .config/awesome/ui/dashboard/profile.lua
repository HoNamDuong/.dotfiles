local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

-- User
local user = wibox.widget({
    halign = "left",
    valign = "bottom",
    widget = wibox.widget.textbox,
})

awful.spawn.easy_async_with_shell("whoami", function(stdout)
    user.markup = string.gsub(pango.b(tostring(stdout)), "\n", "")
end)

-- Hostname
local hostname = wibox.widget({
    halign = "left",
    valign = "top",
    widget = wibox.widget.textbox,
})

awful.spawn.easy_async_with_shell("cat /proc/sys/kernel/hostname", function(stdout)
    hostname.markup = "@" .. string.gsub(tostring(stdout), "\n", "")
end)

-- Uptime
local uptime = wibox.widget({
    halign = "center",
    valign = "center",
    widget = wibox.widget.textbox,
})

gears.timer({
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async_with_shell("uptime -p | sed -e 's/up //g'", function(stdout)
            uptime.text = string.gsub(tostring(stdout), "\n", "")
        end)
    end,
})

local profile = wibox.widget({
    {
        {
            {
                {
                    image = beautiful.os_icon,
                    resize = true,
                    halign = "center",
                    valign = "center",
                    forced_width = dpi(60),
                    forced_height = dpi(60),
                    widget = wibox.widget.imagebox,
                },
                {
                    user,
                    hostname,
                    spacing = beautiful.useless_gap,
                    layout = wibox.layout.flex.vertical,
                },
                spacing = beautiful.useless_gap * 2,
                layout = wibox.layout.fixed.horizontal,
            },
            left = dpi(6) * 4,
            right = dpi(6) * 4,
            top = dpi(6) * 2,
            bottom = dpi(6) * 2,
            widget = wibox.container.margin,
        },
        {
            {
                uptime,
                margins = dpi(6),
                widget = wibox.container.margin,
            },
            bg = beautiful.palette.secondary_60,
            widget = wibox.container.background,
        },
        layout = wibox.layout.fixed.vertical,
    },
    left = dpi(6) * 2,
    right = dpi(6) * 2,
    widget = wibox.container.margin,
})

return profile
