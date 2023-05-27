local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Source https://github.com/vicious-widgets/vicious

-- Initialize function tables
local cpu_usage = {}
local cpu_total = {}
local cpu_active = {}

-- {{{ CPU widget type
local get_cpu = function()
    local cpu_lines = {}

    -- Get CPU stats
    local f = io.open("/proc/stat")

    if f == nil then
        return
    end

    for line in f:lines() do
        if string.sub(line, 1, 3) ~= "cpu" then
            break
        end

        cpu_lines[#cpu_lines + 1] = {}

        for i in string.gmatch(line, "[%s]+([^%s]+)") do
            table.insert(cpu_lines[#cpu_lines], i)
        end
    end
    f:close()

    -- Ensure tables are initialized correctly
    for i = #cpu_total + 1, #cpu_lines do
        cpu_total[i] = 0
        cpu_usage[i] = 0
        cpu_active[i] = 0
    end

    for i, v in ipairs(cpu_lines) do
        -- Calculate totals
        local total_new = 0
        for j = 1, #v do
            total_new = total_new + v[j]
        end
        local active_new = total_new - (v[4] + v[5])

        -- Calculate percentage
        local diff_total = total_new - cpu_total[i]
        local diff_active = active_new - cpu_active[i]

        if diff_total == 0 then
            diff_total = 1E-6
        end
        cpu_usage[i] = math.floor((diff_active / diff_total) * 100)

        -- Store totals
        cpu_total[i] = total_new
        cpu_active[i] = active_new
    end

    return cpu_usage
end
-- }}}

local cpu = wibox.widget({
    {
        {
            id = "cpu_icon",
            image = beautiful.cpu_icon,
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
        id = "cpu_text",
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
        cpu:get_children_by_id("cpu_text")[1].text = get_cpu()[1] .. "%"
    end,
})

return cpu
