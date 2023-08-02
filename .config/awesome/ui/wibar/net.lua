local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Source https://github.com/vicious-widgets/vicious

-- Initialize function tables
local nets = {}
-- Variable definitions
local unit = { ["b"] = 1, ["kb"] = 1024, ["mb"] = 1024 ^ 2, ["gb"] = 1024 ^ 3 }

-- {{{ Format units to one decimal point
local uformat = function(array, key, value, unit_)
    for u, v in pairs(unit_) do
        array["{" .. key .. "_" .. u .. "}"] = string.format("%.1f", value / v)
    end

    return array
end
-- }}}

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

-- {{{ Expose path as a Lua table
local pathtotable = function(dir)
    return setmetatable({ _path = dir }, {
        __index = function(self, index)
            local path = self._path .. "/" .. index
            local f = io.open(path)
            if f then
                local s = f:read("*all")
                f:close()
                if s then
                    return s
                else
                    local o = { _path = path }
                    setmetatable(o, getmetatable(self))
                    return o
                end
            end
        end,
    })
end
-- }}}

-- {{{ Net widget type
local get_net = function()
    local args = {}

    -- Get NET stats
    for line in io.lines("/proc/net/dev") do
        -- Match wmaster0 as well as rt0 (multiple leading spaces)
        local name = string.match(line, "^[%s]?[%s]?[%s]?[%s]?([%w]+):")
        if name ~= nil then
            -- Received bytes, first value after the name
            local recv = tonumber(string.match(line, ":[%s]*([%d]+)"))
            -- Transmited bytes, 7 fields from end of the line
            local send = tonumber(string.match(line, "([%d]+)%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d$"))

            uformat(args, name .. " rx", recv, unit)
            uformat(args, name .. " tx", send, unit)

            -- Operational state and carrier detection
            local sysnet = pathtotable("/sys/class/net/" .. name)
            args["{" .. name .. " carrier}"] = tonumber(sysnet.carrier) or 0

            local now = os.time()
            if nets[name] == nil then
                -- Default values on the first run
                nets[name] = {}
                uformat(args, name .. " down", 0, unit)
                uformat(args, name .. " up", 0, unit)
            else -- Net stats are absolute, substract our last reading
                local interval = now - nets[name].time
                if interval <= 0 then
                    interval = 1
                end

                local down = (recv - nets[name][1]) / interval
                local up = (send - nets[name][2]) / interval

                uformat(args, name .. " down", down, unit)
                uformat(args, name .. " up", up, unit)
            end

            nets[name].time = now

            -- Store totals
            nets[name][1] = recv
            nets[name][2] = send
        end
    end

    return args
end
-- }}}

local net = wibox.widget({
    {
        image = beautiful.download_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "download_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    {
        image = beautiful.upload_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "upload_text",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
})

gears.timer({
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        local result = get_net()
        net:get_children_by_id("download_text")[1].text = format("${eno1 down_mb}", result)
        net:get_children_by_id("upload_text")[1].text = format("${eno1 up_mb}", result)
    end,
})

return net
