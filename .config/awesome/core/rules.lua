local awful = require("awful")
local ruled = require("ruled")
local tags = require("config").tags
local dpi = require("beautiful.xresources").apply_dpi

-- Client
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            -- border_width = dpi(0),
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })
    -- Floating clients.
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = {
                "pavucontrol",
                "nvidia-settings",
                "lxappearance",
                "qt5ct",
                "nitrogen",
                "viewnior",
                "system-config-printer",
            },
            name = {
                "Picture in picture",
            },
            class = {},
            role = {},
        },
        properties = {
            floating = true,
        },
    })
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule({
        id = "titlebars",
        rule_any = {
            type = {
                "normal",
                "dialog",
            },
        },
        properties = {
            titlebars_enabled = true,
        },
    })
    -- Applications
    ruled.client.append_rule({
        rule = { role = "browser" },
        properties = {
            border_width = dpi(0),
            -- titlebars_enabled = false,
            tag = tags[3],
        },
    })
    ruled.client.append_rule({ rule = { instance = "code" }, properties = { tag = tags[2] } })
    ruled.client.append_rule({ rule = { instance = "nemo" }, properties = { tag = tags[4] } })
    ruled.client.append_rule({ rule_any = { instance = { "postman", "DBeaver" } }, properties = { tag = tags[5] } })
    ruled.client.append_rule({ rule_any = { instance = { "mpv" }, class = { "Spotify" } }, properties = { tag = tags[6] } })
    ruled.client.append_rule({ rule_any = { instance = { "telegram", "discord" }, class = { "thunderbird" } }, properties = { tag = tags[8] } })
    ruled.client.append_rule({ rule = { class = "Minecraft" }, properties = { tag = tags[9] } })
    -- No border
    ruled.client.append_rule({ rule = { instance = "conky" }, properties = { border_width = dpi(0) } })
end)

-- Notification
ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "low" },
        properties = {
            implicit_timeout = 5,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "normal" },
        properties = {
            implicit_timeout = 20,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "critical" },
        properties = {
            never_timeout = true,
        },
    })
end)
