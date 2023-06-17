local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local year_popup = awful.widget.calendar_popup.year({
    position = "cc",
    spacing = dpi(0),
    week_numbers = true,
    start_sunday = false,
    long_weekdays = false,
    style_year = {
        padding = dpi(6) * 2,
        border_width = beautiful.border_width,
        bg_color = beautiful.common.background,
        border_color = beautiful.common.secondary,
    },
    style_month = {
        padding = dpi(6),
        border_width = dpi(0),
        bg_color = beautiful.common.background,
    },
    style_yearheader = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = dpi(0),
    },
    style_header = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = dpi(0),
    },
    style_weekday = {
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.foreground,
        bg_color = beautiful.common.secondary,
    },
    style_weeknumber = {
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.secondary,
    },
    style_normal = {
        padding = dpi(6),
        border_width = dpi(0),
    },
    style_focus = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.background,
        bg_color = beautiful.common.primary,
    },
})

local month_popup = awful.widget.calendar_popup.month({
    position = "tr",
    spacing = dpi(0),
    margin = beautiful.useless_gap * 2,
    week_numbers = true,
    start_sunday = false,
    long_weekdays = false,
    style_month = {
        padding = dpi(6),
        border_width = beautiful.border_width,
        bg_color = beautiful.common.background,
        border_color = beautiful.common.secondary,
    },
    style_header = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = dpi(0),
    },
    style_weekday = {
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.foreground,
        bg_color = beautiful.common.secondary,
    },
    style_weeknumber = {
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.secondary,
    },
    style_normal = {
        padding = dpi(6),
        border_width = dpi(0),
    },
    style_focus = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        padding = dpi(6),
        border_width = dpi(0),
        fg_color = beautiful.common.background,
        bg_color = beautiful.common.primary,
    },
})

return {
    year = year_popup,
    month = month_popup,
}
