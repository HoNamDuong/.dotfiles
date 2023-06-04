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
            widget = wibox.container.background,
            bg = is_weekend(date) and beautiful.palette.secondary_150,
            widget,
        })
    elseif flag == "focus" then
        widget.halign = "center"
        widget.valign = "center"
        return wibox.widget({
            widget = wibox.container.background,
            bg = beautiful.palette.primary,
            fg = beautiful.palette.black,
            widget,
        })
    elseif flag == "weeknumber" then
        widget.valign = "center"
        widget.markup = pango.i(pango.span({ foreground = beautiful.palette.secondary, widget.text, " " }))
        return widget
    elseif flag == "weekday" then
        widget.halign = "center"
        widget.markup = pango.i(widget.text)
        return wibox.widget({
            widget = wibox.container.background,
            bg = beautiful.palette.secondary,
            widget,
        })
    elseif flag == "monthheader" or flag == "header" then
        widget.halign = "center"
        widget.markup = pango.b(widget.text)
        return wibox.widget({
            widget = wibox.container.margin,
            margins = dpi(6),
            widget,
        })
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
    font = beautiful.font,
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
            forced_width = dpi(170),
            forced_height = dpi(30),
            widget = wibox.container.background,
            bg = beautiful.palette.secondary .. "80",
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
    top = dpi(6),
    bottom = dpi(6),
    left = dpi(12),
    right = dpi(12),
    widget = wibox.container.margin,
})

return calendar
