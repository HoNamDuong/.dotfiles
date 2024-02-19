local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi

local keys = require("config").keys

local hotkeys = hotkeys_popup.widget.new({
    width = dpi(6) * 10 * 24,
    height = dpi(6) * 10 * 10,
})

awesome.connect_signal("hotkeys::show", function()
    hotkeys:show_help()
end)

awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "s", function()
        awesome.emit_signal("hotkeys::show")
    end, { description = "Show help", group = "awesome" }),
})
