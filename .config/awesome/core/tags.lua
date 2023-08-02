local awful = require("awful")
local beautiful = require("beautiful")
local tag_name = require("config").tags.name

local tags = {
    name = tag_name,
    icon = {
        beautiful.terminal_icon,
        beautiful.code_icon,
        beautiful.chrome_icon,
        beautiful.files_icon,
        beautiful.document_icon,
        beautiful.media_icon,
        beautiful.tools_icon,
        beautiful.chat_icon,
        beautiful.game_icon,
        beautiful.general_icon,
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
