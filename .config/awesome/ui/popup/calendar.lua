local awful = require("awful")
local beautiful = require("beautiful")

local year_popup = awful.widget.calendar_popup.year({
    position = "cc",
    spacing = 0,
    week_numbers = true,
    start_sunday = false,
    long_weekdays = false,
    style_year = {
        padding = 12,
        border_width = 2,
        bg_color = beautiful.palette.background,
        border_color = beautiful.palette.secondary,
    },
    style_month = {
        padding = 6,
        border_width = 0,
        bg_color = beautiful.palette.background,
    },
    style_yearheader = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = 0,
    },
    style_header = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = 0,
    },
    style_weekday = {
        padding = 6,
        border_width = 0,
        fg_color = beautiful.palette.fontground,
        bg_color = beautiful.palette.secondary,
    },
    style_weeknumber = {
        border_width = 0,
        fg_color = beautiful.palette.secondary,
    },
    style_normal = {
        padding = 6,
        border_width = 0,
    },
    style_focus = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        padding = 6,
        border_width = 0,
        fg_color = beautiful.palette.background,
        bg_color = beautiful.palette.primary,
    },
})

local month_popup = awful.widget.calendar_popup.month({
    position = "tr",
    spacing = 0,
    margin = 6,
    week_numbers = true,
    start_sunday = false,
    long_weekdays = false,
    style_month = {
        padding = 6,
        border_width = 2,
        bg_color = beautiful.palette.background,
        border_color = beautiful.palette.secondary,
    },
    style_header = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        border_width = 0,
    },
    style_weekday = {
        padding = 6,
        border_width = 0,
        fg_color = beautiful.palette.fontground,
        bg_color = beautiful.palette.secondary,
    },
    style_weeknumber = {
        border_width = 0,
        fg_color = beautiful.palette.secondary,
    },
    style_normal = {
        padding = 6,
        border_width = 0,
    },
    style_focus = {
        markup = function(t)
            return "<b>" .. t .. "</b>"
        end,
        padding = 6,
        border_width = 0,
        fg_color = beautiful.palette.background,
        bg_color = beautiful.palette.primary,
    },
})

return {
    year = year_popup,
    month = month_popup,
}
