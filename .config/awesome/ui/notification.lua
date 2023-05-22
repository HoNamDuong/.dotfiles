local naughty = require("naughty")
local item = require("ui.popup.notifications.item")
local dpi = require("beautiful.xresources").apply_dpi

-- Default
naughty.connect_signal("request::display", function(n)
    naughty.layout.box({
        type = "notification",
        notification = n,
        border_width = 0,
        minimum_width = dpi(360),
        maximum_width = dpi(360),
        widget_template = item.notification_item(n),
    })
end)

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
