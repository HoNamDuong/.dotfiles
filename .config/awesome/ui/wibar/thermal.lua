local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Source https://github.com/vicious-widgets/vicious

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

-- {{{ Thermal widget type
local get_thermal = function(warg)
    if not warg then
        return
    end

    local zone = { -- Known temperature data sources
        ["sys"] = { "/sys/class/thermal/", file = "temp", div = 1000 },
        ["core"] = { "/sys/devices/platform/", file = "temp2_input", div = 1000 },
        ["hwmon"] = { "/sys/class/hwmon/", file = "temp1_input", div = 1000 },
        ["proc"] = { "/proc/acpi/thermal_zone/", file = "temperature" },
    } --  Default to /sys/class/thermal
    warg = type(warg) == "table" and warg or { warg, "sys" }

    -- Get temperature from thermal zone
    local _thermal = pathtotable(zone[warg[2]][1] .. warg[1])

    local data = warg[3] and _thermal[warg[3]] or _thermal[zone[warg[2]].file]
    if data then
        if zone[warg[2]].div then
            return { math.floor(data / zone[warg[2]].div) }
        else -- /proc/acpi "temperature: N C"
            return { tonumber(string.match(data, "[%d]+")) }
        end
    end

    return { 0 }
end
-- }}}

local thermal = wibox.widget({
    {
        id = "icon_role",
        image = beautiful.temperature_icon,
        resize = true,
        halign = "center",
        valign = "center",
        forced_width = dpi(6) * 3,
        forced_height = dpi(6) * 3,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text_role",
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
        thermal:get_children_by_id("text_role")[1].text = get_thermal("thermal_zone4")[1] .. "°C"
    end,
})

return thermal
