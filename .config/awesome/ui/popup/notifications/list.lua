local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local item = require("ui.popup.notifications.item")

local notification_list = wibox.widget({
    spacing = beautiful.useless_gap * 2,
    layout = wibox.layout.fixed.vertical,
})

local pointer = 0
local min_widgets = 5

notification_list:connect_signal("button::press", function(_, _, _, button)
    if button == 5 then -- up scrolling
        if pointer < #notification_list.children and ((#notification_list.children - pointer) >= min_widgets) then
            pointer = pointer + 1
            notification_list.children[pointer].visible = false
        end
    elseif button == 4 then -- down scrolling
        if pointer > 0 then
            notification_list.children[pointer].visible = true
            pointer = pointer - 1
        end
    end
end)

naughty.connect_signal("request::display", function(n)
    local widget = wibox.widget(item.notification_item(n))

    notification_list:insert(1, widget)

    widget:get_children_by_id("layout_role")[1]:add(item.delete_button(widget, notification_list))
end)

return notification_list
