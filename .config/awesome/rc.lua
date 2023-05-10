-- awesome_mode: api-level=4:screen=on
pcall(require, "luarocks.loader")

require("theme")
require("core")
require("ui")

--- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
