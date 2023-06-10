-- If LuaRocks is installed, make sure that packages installed through it are found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Theme
require("themes")

-- Core
require("core.layouts")
require("core.tags")
require("core.clients")
require("core.rules")
require("core.bindings")

-- Ui
require("ui.notification")
require("ui.titlebar")
require("ui.wibar")
require("ui.layoutlist")
require("ui.switcher")

-- Enable for lower memory consumption
--- @diagnostic disable: param-type-mismatch
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
--- @diagnostic enable: param-type-mismatch
