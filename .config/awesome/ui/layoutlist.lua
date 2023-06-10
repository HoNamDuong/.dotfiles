local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local keys = require("config").keys
local dpi = require("beautiful.xresources").apply_dpi

local layoutlist = awful.popup({
    widget = awful.widget.layoutlist({
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        strategy = "exact",
                        height = dpi(60) * 2,
                        width = dpi(60) * 2,
                        widget = wibox.container.constraint,
                    },
                    {
                        id = "text_role",
                        halign = "center",
                        valign = "center",
                        font = beautiful.font,
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                margins = beautiful.useless_gap * 2,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    }),
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

-- Switch layout
awful.keygrabber({
    start_callback = function()
        layoutlist.visible = true
    end,
    stop_callback = function()
        layoutlist.visible = false
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
