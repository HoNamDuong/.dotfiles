local awful = require("awful")
local ruled = require("ruled")
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 50

-- {{{ Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
-- }}}

-- {{{ Notifications
ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        },
    })
end)
naughty.connect_signal("request::display", function(n)
    naughty.layout.box({ notification = n })
end)
-- }}}
