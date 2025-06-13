local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local pango = require("utils").pango

local gpu = wibox.widget({
    {
        {
            {
                id = "gpu_icon_role",
                image = beautiful.gpu_icon,
                resize = true,
                halign = "center",
                valign = "center",
                forced_width = dpi(6) * 3,
                forced_height = dpi(6) * 3,
                widget = wibox.widget.imagebox,
            },
            {
                id = "gpu_utilization_text_role",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            {
                id = "gpu_usep_text_role",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            {
                id = "gpu_temperature_text_role",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(6),
        right = dpi(6),
        widget = wibox.container.margin,
    },
    bg = beautiful.colors.background,
    widget = wibox.container.background,
})

awful.spawn.easy_async("which nvidia-smi", function(stdout, stderr, reason, exit_code)
    if exit_code == 0 then
        gears.timer({
            timeout = 1,
            call_now = true,
            autostart = true,
            callback = function()
                awful.spawn.easy_async({ "sh", "-c", "nvidia-smi --query-gpu=utilization.gpu,memory.total,memory.used,temperature.gpu --format=csv,noheader,nounits" }, function(out)
                    local gpu_utilization, gpu_total, gpu_used, gpu_temperature = string.match(string.gsub(out, "%\n", ""), "^(.-)%, (.-)%, (.-)%, (.-)$")

                    -- utilization
                    if gpu_utilization then
                        gpu_utilization = tonumber(gpu_utilization)

                        local gpu_utilization_fg_color = beautiful.colors.low
                        if gpu_utilization > 70 then
                            gpu_utilization_fg_color = beautiful.colors.high
                        elseif 30 <= gpu_utilization and gpu_utilization <= 70 then
                            gpu_utilization_fg_color = beautiful.colors.medium
                        end
                        gpu:get_children_by_id("gpu_utilization_text_role")[1].markup = pango.span({ gpu_utilization .. "%", foreground = gpu_utilization_fg_color })
                    else
                        gpu:get_children_by_id("gpu_utilization_text_role")[1].text = "N/A"
                    end

                    -- used
                    if gpu_used and gpu_total then
                        local gpu_usep = math.floor(gpu_used / gpu_total * 100)

                        local gpu_usep_fg_color = beautiful.colors.low
                        if gpu_usep > 70 then
                            gpu_usep_fg_color = beautiful.colors.high
                        elseif 30 <= gpu_usep and gpu_usep <= 70 then
                            gpu_usep_fg_color = beautiful.colors.medium
                        end
                        gpu:get_children_by_id("gpu_usep_text_role")[1].markup = pango.span({ gpu_usep .. "%", foreground = gpu_usep_fg_color })
                    else
                        gpu:get_children_by_id("gpu_usep_text_role")[1].text = "N/A"
                    end

                    -- temperature
                    if gpu_temperature then
                        gpu_temperature = tonumber(gpu_temperature)

                        local gpu_temperature_fg_color = beautiful.colors.low
                        if gpu_temperature > 80 then
                            gpu_temperature_fg_color = beautiful.colors.high
                        elseif 60 <= gpu_temperature and gpu_temperature <= 80 then
                            gpu_temperature_fg_color = beautiful.colors.medium
                        end
                        gpu:get_children_by_id("gpu_temperature_text_role")[1].markup = pango.span({ gpu_temperature .. "°C", foreground = gpu_temperature_fg_color })
                    else
                        gpu:get_children_by_id("gpu_temperature_text_role")[1].text = "N/A"
                    end
                end)
            end,
        })
    else
        gpu:get_children_by_id("gpu_utilization_text_role")[1].text = "N/A"
        gpu:get_children_by_id("gpu_usep_text_role")[1].text = "N/A"
        gpu:get_children_by_id("gpu_temperature_text_role")[1].text = "N/A"
    end
end)

return gpu
