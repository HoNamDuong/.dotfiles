local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local config = require("config")
local countdown_text = require("ui.wibar.countdown")
local pango = require("utils").pango
local dpi = require("beautiful.xresources").apply_dpi
local recolor_image = require("gears.color").recolor_image

local function clamp(value, min, max)
    if value < min then
        return min
    end
    if value > max then
        return max
    end
    return value
end

local function run()
    awful.spawn(config.actions.shutdown)
end

local defuult_minute = 5

local countdown = {
    textbox = countdown_text:get_children_by_id("text_role")[1],
    minute = defuult_minute,
    second = 0,
}

function countdown:update_time()
    self.time:get_children_by_id("hour_number")[1]:set_text(math.floor(self.minute / 60) .. " hours")
    self.time:get_children_by_id("minute_number")[1]:set_text(math.fmod(self.minute, 60) .. " minutes")
end

function countdown:change_minute(number)
    self.minute = clamp(self.minute + number, 1, 24 * 60)

    self:update_time()
end

function countdown:start()
    if self.timer and self.timer.started then
        return
    end

    self.second = tonumber(self.minute * 60)
    if self.second <= 0 then
        return
    end

    self.timer = gears.timer({
        timeout = 1,
        call_now = true,
        callback = function()
            if self.second > 0 then
                local hours = math.floor(self.second / 3600)
                local minutes = math.floor((self.second - (hours * 3600)) / 60)
                local seconds = math.fmod(self.second, 60)
                self.textbox:set_markup(pango.span({
                    pango.b(string.format("%02d:%02d:%02d", hours, minutes, seconds)),
                    foreground = beautiful.common.medium,
                }))
                self.second = self.second - 1
            else
                self.textbox:set_markup(pango.span({
                    pango.b("Not scheduled"),
                    foreground = beautiful.common.medium,
                }))
                self.timer:stop()

                self.control:get_children_by_id("start_icon")[1].image = recolor_image(beautiful.play_icon, beautiful.common.low)
                self.control:get_children_by_id("stop_icon")[1].image = recolor_image(beautiful.stop_icon, beautiful.common.secondary)
                countdown_text.visible = false

                -- run function
                run()
            end
        end,
    })

    self.timer:start()

    self.control:get_children_by_id("start_icon")[1].image = recolor_image(beautiful.play_icon, beautiful.common.secondary)
    self.control:get_children_by_id("stop_icon")[1].image = recolor_image(beautiful.stop_icon, beautiful.common.high)
    self.minute = defuult_minute
    self:update_time()
    countdown_text.visible = true
end

function countdown:stop()
    if self.timer and self.timer.started then
        self.textbox:set_markup(pango.span({
            pango.b("Not scheduled"),
            foreground = beautiful.common.medium,
        }))
        self.timer:stop()

        self.control:get_children_by_id("start_icon")[1].image = recolor_image(beautiful.play_icon, beautiful.common.low)
        self.control:get_children_by_id("stop_icon")[1].image = recolor_image(beautiful.stop_icon, beautiful.common.secondary)
        self.second = 0
        countdown_text.visible = false
    end
end

countdown.control = wibox.widget({
    {
        id = "start_icon",
        image = recolor_image(beautiful.play_icon, beautiful.common.low),
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 5,
        forced_height = dpi(6) * 5,
        widget = wibox.widget.imagebox,
        buttons = {
            awful.button({}, 1, function()
                countdown:start()
            end),
        },
    },
    {
        id = "stop_icon",
        image = recolor_image(beautiful.stop_icon, beautiful.common.secondary),
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 5,
        forced_height = dpi(6) * 5,
        widget = wibox.widget.imagebox,
        buttons = {
            awful.button({}, 1, function()
                countdown:stop()
            end),
        },
    },
    layout = wibox.layout.flex.vertical,
})

countdown.time = wibox.widget({
    { -- hours
        {
            image = beautiful.subtract_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    countdown:change_minute(-60)
                end),
            },
        },
        {
            {
                id = "hour_number",
                text = math.floor(defuult_minute / 60) .. " hours",
                halign = "left",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            left = dpi(6) * 1,
            right = dpi(6) * 1,
            widget = wibox.container.margin,
        },
        {
            image = beautiful.add_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    countdown:change_minute(60)
                end),
            },
        },
        layout = wibox.layout.align.horizontal,
    },
    { -- minutes
        {
            image = beautiful.subtract_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    countdown:change_minute(-1)
                end),
            },
        },
        {
            {
                id = "minute_number",
                text = math.fmod(defuult_minute, 60) .. " minutes",
                halign = "left",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            left = dpi(6) * 1,
            right = dpi(6) * 1,
            widget = wibox.container.margin,
        },
        {
            image = beautiful.add_icon,
            resize = true,
            halign = "center",
            valign = "center",
            forced_width = dpi(6) * 5,
            forced_height = dpi(6) * 5,
            widget = wibox.widget.imagebox,
            buttons = {
                awful.button({}, 1, function()
                    countdown:change_minute(1)
                end),
            },
        },
        layout = wibox.layout.align.horizontal,
    },
    layout = wibox.layout.flex.vertical,
})

countdown.widget = wibox.widget({
    {
        {
            {
                countdown.textbox,
                margins = dpi(6),
                widget = wibox.container.margin,
            },
            bg = beautiful.common.medium_dark,
            widget = wibox.container.background,
        },
        {
            countdown.control,
            countdown.time,
            layout = wibox.layout.fixed.horizontal,
        },
        spacing = dpi(6),
        layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.place,
})

return countdown.widget
