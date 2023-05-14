local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")
local hotkeys = require("ui.popup.hotkeys")

local mainmenu = awful.menu({
    items = {
        {
            "Awesome",
            {
                {
                    "Hotkeys",
                    function()
                        hotkeys:show_help()
                    end,
                },
                { "Manual", config.apps.terminal .. " -e man awesome" },
                { "Edit config", config.apps.editor .. " " .. awesome.conffile },
                { "Reload", awesome.restart },
            },
            beautiful.awesome_icon,
        },
        { "Lock", config.power.lock, beautiful.power_lock },
        { "Logout", config.power.logout, beautiful.power_logout },
        { "Sleep", config.power.sleep, beautiful.power_sleep },
        { "Restart", config.power.restart, beautiful.power_restart },
        { "Shutdown", config.power.shutdown, beautiful.power_shutdown },
    },
})

return mainmenu
