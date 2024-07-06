local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local clock = wibox.widget({
    {
        {
            {
                id = "clock_icon_role",
                image = beautiful.clock_icon,
                resize = true,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                id = "clock_text_role",
                format = "%H:%M",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textclock,
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
})

awful.tooltip({
    objects = { clock },
    timer_function = function()
        return os.date("Today is %A %B %d %Y\nThe time is %T\nClick to copy time to the clipboard")
    end,
    align = "bottom",
    mode = "outside",
})

clock:add_button(awful.button({}, 1, nil, function()
    local time = tostring(os.date("%Y%m%d%H%M"))
    io.popen("xclip -selection clipboard", "w"):write(time):close()
end))

return clock
