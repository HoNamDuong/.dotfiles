local awful = require("awful")
local ruled = require("ruled")
local tag_name = require("config").tags.name
local dpi = require("beautiful.xresources").apply_dpi

-- Client
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            -- border_width = dpi(0),
            -- titlebars_enabled = true,
            raise = true,
            focus = awful.client.focus.filter,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })
    -- Floating clients
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
                "nm-connection-editor",
                "qalculate-gtk",
                "arandr",
                "Minecraft",
            },
            name = {},
            class = {},
            role = {
                "pop-up",
            },
            type = {
                "dialog",
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        },
    })
    -- Picture in picture
    ruled.client.append_rule({
        rule_any = {
            name = {
                "Picture in picture",
            },
        },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            titlebars_enabled = false,
        },
    })
    -- No border
    ruled.client.append_rule({
        rule = { instance = "conky" },
        properties = {
            border_width = dpi(0),
        },
    })
    -- Move to tag
    ruled.client.append_rule({
        rule_any = { instance = {} },
        properties = { tag = tag_name[1] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "code" } },
        properties = { tag = tag_name[2] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "google-chrome" } },
        properties = { tag = tag_name[3] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "nemo" } },
        properties = { tag = tag_name[4] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "zathura" } },
        properties = { tag = tag_name[5] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "mpv" }, class = { "Spotify" } },
        properties = { tag = tag_name[6] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "postman", "DBeaver", "VirtualBox", "simple-scan" } },
        properties = { tag = tag_name[7] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "telegram", "discord" }, class = { "thunderbird" } },
        properties = { tag = tag_name[8] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "Minecraft" } },
        properties = { tag = tag_name[9] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "lxappearance", "qt5ct", "nitrogen", "arandr", "nm-connection-editor" } },
        properties = { tag = tag_name[10] },
    })
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
            implicit_timeout = 10,
        },
    })
    ruled.notification.append_rule({
        rule = { urgency = "critical" },
        properties = {
            implicit_timeout = 20,
        },
    })
end)
