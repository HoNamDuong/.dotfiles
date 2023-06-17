local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local pango = require("utils").pango
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
        id = "icon_role",
        image = beautiful.cpu_icon,
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
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        local usep = get_cpu()[1]
        local fg_color = beautiful.common.low

        if usep > 80 then
            fg_color = beautiful.common.high
        elseif 50 <= usep and usep <= 80 then
            fg_color = beautiful.common.medium
        end

        cpu:get_children_by_id("text_role")[1].markup = pango.span({ usep .. "%", foreground = fg_color })
    end,
})

return cpu
