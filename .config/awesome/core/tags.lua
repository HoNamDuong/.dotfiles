local awful = require("awful")
local beautiful = require("beautiful")
local tag_name = require("config").tags.name

local tags = {
    name = tag_name,
    icon = {
        beautiful.tag_terminal,
        beautiful.tag_code,
        beautiful.tag_chrome,
        beautiful.tag_files,
        beautiful.tag_document,
        beautiful.tag_media,
        beautiful.tag_edit,
        beautiful.tag_chat,
        beautiful.tag_game,
        beautiful.tag_general,
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
