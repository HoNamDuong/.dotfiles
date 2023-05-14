-- awesome_mode: api-level=4:screen=on
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

-- --- Enable for lower memory consumption
-- collectgarbage("setpause", 110)
-- collectgarbage("setstepmul", 1000)
