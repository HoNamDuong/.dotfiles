local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Source https://github.com/vicious-widgets/vicious

-- {{{ Format a string with args
local format = function(format, args)
    for var, val in pairs(args) do
        if tonumber(var) == nil then
            var = var:gsub("[-+?*]", function(i)
                return "%" .. i
            end)
        end
        if type(val) == "string" then
            val = val:gsub("%%", "%%%%")
        end
        format = format:gsub("$" .. var, val)
    end
    return format
end
-- }}}

-- {{{ Format units to one decimal point
local uformat = function(array, key, value, unit)
    for u, v in pairs(unit) do
        array["{" .. key .. "_" .. u .. "}"] = string.format("%.1f", value / v)
    end
    return array
end
-- }}}

-- {{{ FS: provides file system disk space usage
-- Mebibyte and gibibyte respectively, because backward compatibility
local UNIT = { mb = 1024, gb = 1024 ^ 2 }

local get_fs = function(callback)
    local fs_info = {} -- Get data from df
    awful.spawn.with_line_callback({ awful.util.shell, "-c", "LC_ALL=C df -kP" or "LC_ALL=C df -klP" }, {
        stdout = function(line)
            -- (1024-blocks) (Used) (Available) (Capacity)% (Mounted on)
            local s, u, a, p, m = line:match("^.-%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%%%s+([%p%w]+)")

            if u and m then -- Handle 1st line and broken regexp
                uformat(fs_info, m .. " size", s, UNIT)
                uformat(fs_info, m .. " used", u, UNIT)
                uformat(fs_info, m .. " avail", a, UNIT)

                fs_info["{" .. m .. " used_p}"] = tonumber(p)
                fs_info["{" .. m .. " avail_p}"] = 100 - tonumber(p)
            end
        end,
        output_done = function()
            callback(fs_info)
        end,
    })
end
-- }}}

local fs = wibox.widget({
    {
        {
            id = "fs_icon",
            image = beautiful.hard_drive_icon,
            resize = true,
            halign = "center",
            widget = wibox.widget.imagebox,
        },
        margins = {
            left = dpi(6),
            right = dpi(6),
            top = dpi(3),
            bottom = dpi(3),
        },
        widget = wibox.container.margin,
    },
    {
        id = "fs_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
})

gears.timer({
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = function()
        get_fs(function(fs_info)
            fs:get_children_by_id("fs_text")[1].text = format("${/ used_p}", fs_info) .. "%"
        end)
    end,
})

return fs
