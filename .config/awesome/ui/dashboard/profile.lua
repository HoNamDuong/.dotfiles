local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local pango = require("utils").pango

-- User
local user = wibox.widget({
    halign = "left",
    valign = "center",
    font = beautiful.font_name .. " " .. 14,
    widget = wibox.widget.textbox,
})

awful.spawn.easy_async_with_shell("whoami", function(stdout)
    user.markup = pango.b(tostring(stdout))
end)

-- Hostname
local hostname = wibox.widget({
    halign = "left",
    valign = "center",
    widget = wibox.widget.textbox,
})

awful.spawn.easy_async_with_shell("cat /proc/sys/kernel/hostname", function(stdout)
    hostname.markup = "@" .. tostring(stdout)
end)

local profile = wibox.widget({
    {
        {
            image = beautiful.os_icon,
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
        },
        {
            user,
            hostname,
            layout = wibox.layout.flex.vertical,
        },
        spacing = beautiful.useless_gap * 2,
        layout = wibox.layout.fixed.horizontal,
    },
    margins = beautiful.useless_gap * 6,
    widget = wibox.container.margin,
})

return profile
