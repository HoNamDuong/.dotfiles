local filesystem = require("gears.filesystem")
local beautiful = require("beautiful")

beautiful.init(filesystem.get_configuration_dir() .. "themes/default/theme.lua")
