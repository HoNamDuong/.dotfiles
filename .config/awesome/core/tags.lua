local awful = require("awful")
local tags = require("config").tags

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag(tags, s, awful.layout.layouts[1])
end)
