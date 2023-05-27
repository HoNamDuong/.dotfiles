local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Source https://github.com/vicious-widgets/vicious

-- {{{ Memory widget type
local get_mem = function()
    local _mem = { buf = {}, swp = {} }

    -- Get MEM info
    for line in io.lines("/proc/meminfo") do
        for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
            if k == "MemTotal" then
                _mem.total = math.floor(v / 1024)
            elseif k == "MemFree" then
                _mem.buf.f = math.floor(v / 1024)
            elseif k == "MemAvailable" then
                _mem.buf.a = math.floor(v / 1024)
            elseif k == "Buffers" then
                _mem.buf.b = math.floor(v / 1024)
            elseif k == "Cached" then
                _mem.buf.c = math.floor(v / 1024)
            elseif k == "SwapTotal" then
                _mem.swp.t = math.floor(v / 1024)
            elseif k == "SwapFree" then
                _mem.swp.f = math.floor(v / 1024)
            end
        end
    end

    -- Calculate memory percentage
    _mem.free = _mem.buf.a
    _mem.inuse = _mem.total - _mem.free
    _mem.bcuse = _mem.total - _mem.buf.f
    _mem.usep = math.floor(_mem.inuse / _mem.total * 100)
    -- Calculate swap percentage
    _mem.swp.inuse = _mem.swp.t - _mem.swp.f
    _mem.swp.usep = math.floor(_mem.swp.inuse / _mem.swp.t * 100)

    return { _mem.usep, _mem.inuse, _mem.total, _mem.free, _mem.swp.usep, _mem.swp.inuse, _mem.swp.t, _mem.swp.f, _mem.bcuse }
end
-- }}}

local mem = wibox.widget({
    {
        {
            id = "mem_icon",
            image = beautiful.memory_icon,
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
        id = "mem_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
})

gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        mem:get_children_by_id("mem_text")[1].text = get_mem()[1] .. "%"
    end,
})

return mem
