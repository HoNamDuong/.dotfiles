local awful = require("awful")
local tags = require("config").tags

awful.tag(tags, nil, awful.layout.layouts[1])
