local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local keys = require("config").keys

screen.connect_signal("request::desktop_decoration", function(s)
    s.layoutlist = awful.popup({
        screen = s,
        widget = awful.widget.layoutlist({
            screen = s,
            widget_template = {
                {
                    {
                        {
                            {
                                id = "icon_role",
                                widget = wibox.widget.imagebox,
                            },
                            strategy = "exact",
                            width = dpi(6) * 10 * 2,
                            height = dpi(6) * 10 * 2,
                            widget = wibox.container.constraint,
                        },
                        {
                            id = "text_role",
                            halign = "center",
                            valign = "center",
                            widget = wibox.widget.textbox,
                        },
                        spacing = dpi(6) * 2,
                        layout = wibox.layout.fixed.vertical,
                    },
                    margins = dpi(6) * 2,
                    widget = wibox.container.margin,
                },
                id = "background_role",
                widget = wibox.container.background,
            },
        }),
        type = "dock",
        placement = awful.placement.centered,
        border_width = beautiful.border_width,
        border_color = beautiful.colors.secondary,
        ontop = true,
        visible = false,
    })
end)

-- Switch layout
awful.keygrabber({
    start_callback = function()
        awful.screen.focused().layoutlist.visible = true
    end,
    stop_callback = function()
        awful.screen.focused().layoutlist.visible = false
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = { "Escape", "Super_L", "Super_R" },
    keybindings = {
        {
            { keys.super },
            " ",
            function()
                awful.layout.inc(1)
            end,
            {
                description = "Select next layout",
                group = "layout",
            },
        },
        {
            { keys.super, "Shift" },
            " ",
            function()
                awful.layout.inc(-1)
            end,
            {
                description = "Select previous layout",
                group = "layout",
            },
        },
    },
})
