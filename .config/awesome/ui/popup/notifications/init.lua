local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

awful.screen.connect_for_each_screen(function(s)
    s.notifications = wibox({
        type = "toolbar",
        screen = s,
        ontop = true,
        visible = false,
        width = dpi(360),
        height = s.workarea.height - (beautiful.useless_gap * 4) - (beautiful.useless_gap * 4) - (beautiful.border_width * 2),
        border_width = beautiful.border_width,
        border_color = beautiful.palette.secondary,
    })

    awful.placement.bottom_right(s.notifications, {
        honor_workarea = true,
        margins = beautiful.useless_gap * 2,
    })

    local list = require("ui.popup.notifications.list")
    local alert = require("ui.popup.notifications.alert")

    s.notifications:setup({
        {
            {
                {
                    markup = "<b>Notifications</b>",
                    align = "center",
                    valign = "center",
                    font = beautiful.font_name .. " 24",
                    widget = wibox.widget.textbox,
                },
                margins = beautiful.useless_gap * 2,
                widget = wibox.container.margin,
            },
            alert,
            list,
            spacing = beautiful.useless_gap * 2,
            layout = wibox.layout.fixed.vertical,
        },
        margins = beautiful.useless_gap * 2,
        widget = wibox.container.margin,
    })

    function s.notifications:toggle()
        self.visible = not self.visible
    end
end)

awesome.connect_signal("notifications::toggle", function()
    awful.screen.focused().notifications:toggle()
end)
