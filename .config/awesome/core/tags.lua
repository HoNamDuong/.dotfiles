local awful = require("awful")
local beautiful = require("beautiful")

local tag_name = require("config").tags.name

local tags = {
    name = tag_name,
    icon = {
        beautiful.general_icon,
        beautiful.code_icon,
        beautiful.chrome_icon,
        beautiful.file_icon,
        beautiful.document_icon,
        beautiful.media_icon,
        beautiful.tool_icon,
        beautiful.chat_icon,
        beautiful.game_icon,
        beautiful.setting_icon,
    },
}

screen.connect_signal("request::desktop_decoration", function(s)
    for i = 1, 10 do
        awful.tag.add(tags.name[i], {
            layout = awful.layout.layouts[1],
            icon = tags.icon[i],
            screen = s,
            selected = i == 1,
        })
    end
end)
