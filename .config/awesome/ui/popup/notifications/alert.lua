local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local alert = wibox.widget({
    {
        {
            id = "text_role",
            markup = "",
            valign = "center",
            font = beautiful.font_name .. " 10",
            widget = wibox.widget.textbox,
        },
        margins = beautiful.useless_gap * 2,
        widget = wibox.container.margin,
    },
    bg = beautiful.palette.secondary,
    widget = wibox.container.background,
    set_txt = function(self, txt)
        self:get_children_by_id("text_role")[1].markup = txt
    end,
    visible = false,
})

awesome.connect_signal("notifications::message", function(msg)
    alert.txt = "<i>" .. msg .. "</i>"
    alert.visible = true

    gears.timer({
        timeout = 4,
        autostart = true,
        single_shot = true,
        callback = function()
            alert.visible = false
            alert.txt = ""
        end,
    })
end)

return alert
