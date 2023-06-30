local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi

-- Content
local function is_weekend(date)
    return date.wday == 1 or date.wday == 7
end

local function decorate_cell(widget, flag, date)
    if flag == "normal" then
        widget.halign = "center"
        widget.valign = "center"
        return wibox.widget({
            widget,
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            bg = is_weekend(date) and beautiful.common.secondary_dark,
            widget = wibox.container.background,
        })
    elseif flag == "focus" then
        widget.halign = "center"
        widget.valign = "center"
        return wibox.widget({
            widget,
            bg = beautiful.common.primary,
            fg = beautiful.common.background,
            widget = wibox.container.background,
        })
    elseif flag == "weeknumber" then
        widget.halign = "center"
        widget.valign = "center"
        widget.markup = pango.i(pango.span({ foreground = beautiful.common.secondary, widget.text }))
        return widget
    elseif flag == "weekday" then
        widget.halign = "center"
        widget.valign = "center"
        widget.markup = pango.i(widget.text)
        return wibox.widget({
            widget,
            bg = beautiful.common.secondary,
            widget = wibox.container.background,
        })
    elseif flag == "monthheader" or flag == "header" then
        widget.markup = pango.b(widget.text)
        return widget
    elseif flag == "month" then
        return widget
    else
        return widget
    end
end

local cal_content = wibox.widget({
    date = os.date("*t"),
    fn_embed = decorate_cell,
    week_numbers = true,
    long_weekdays = false,
    start_sunday = false,
    spacing = dpi(0),
    font = beautiful.font_name .. " " .. 12,
    widget = wibox.widget.calendar.month,
})

-- Contral
local function today()
    cal_content:set_date(os.date("*t"))
end

local function move(direction)
    local a = cal_content:get_date()
    a.month = a.month + direction
    local now = os.date("*t")
    if a.year == now.year and a.month == now.month then
        today()
    else
        cal_content:set_date({
            year = a.year,
            month = a.month,
        })
    end
end

local cal_control = wibox.widget({
    {
        {
            image = beautiful.arrow_left_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    move(-1)
                end),
            },
        },
        halign = "right",
        valign = "top",
        layout = wibox.container.place,
    },
    {
        {
            forced_width = dpi(6) * 5 * 6,
            forced_height = dpi(6) * 5,
            bg = beautiful.common.secondary_dark,
            widget = wibox.container.background,
            buttons = {
                awful.button({}, 1, function()
                    today()
                end),
            },
        },
        valign = "top",
        layout = wibox.container.place,
    },
    {
        {
            image = beautiful.arrow_right_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    move(1)
                end),
            },
        },
        halign = "left",
        valign = "top",
        layout = wibox.container.place,
    },
    expand = "none",
    layout = wibox.layout.align.horizontal,
})

local calendar = wibox.widget({
    {
        cal_control,
        cal_content,
        layout = wibox.layout.stack,
    },
    valign = "top",
    widget = wibox.container.place,
})

return calendar
