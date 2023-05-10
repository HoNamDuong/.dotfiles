local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")
local hotkeys_popup = require("awful.hotkeys_popup")
local util = require("util")

-- {{{ Menu
local main = util.menu_build({
    before = {
        {
            "Awesome",
            {
                {
                    "Hotkeys",
                    function()
                        hotkeys_popup.show_help(nil, awful.screen.focused())
                    end,
                },
                { "Manual", config.apps.terminal .. " -e man awesome" },
                { "Edit config", config.apps.editor .. " " .. awesome.conffile },
                { "Reload", awesome.restart },
            },
            beautiful.awesome_icon,
        },
    },
    after = {
        { "Lock", config.power.lock },
        { "Logout", config.power.logout },
        { "Sleep", config.power.suspend },
        { "Restart", config.power.reboot },
        { "Shutdown", config.power.shutdown },
    },
})

-- local main = awful.menu({
--     items = {
--         {
--             "Awesome",
--             {
--                 {
--                     "Hotkeys",
--                     function()
--                         hotkeys_popup.show_help(nil, awful.screen.focused())
--                     end,
--                 },
--                 { "Manual", config.apps.terminal .. " -e man awesome" },
--                 { "Edit config", config.apps.editor .. " " .. awesome.conffile },
--                 { "Reload", awesome.restart },
--             },
--             beautiful.awesome_icon,
--         },
--         { "Lock", config.power.lock },
--         { "Logout", config.power.logout },
--         { "Sleep", config.power.suspend },
--         { "Restart", config.power.reboot },
--         { "Shutdown", config.power.shutdown },
--     },
-- })

return main
