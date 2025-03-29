local awful = require("awful")
local ruled = require("ruled")
local dpi = require("beautiful.xresources").apply_dpi

local tag_name = require("config").tags.name

-- Client
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule
    ruled.client.append_rule({
        rule = {},
        properties = {
            -- border_width = dpi(0),
            titlebars_enabled = true,
            -- size_hints_honor = false,
            raise = true,
            focus = awful.client.focus.filter,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })
    -- Floating clients
    ruled.client.append_rule({
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
                "nm-applet",
                "qalculate-gtk",
                "arandr",
                "Minecraft",
                "gpick",
                "blueman",
                "FileRoller"
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
    -- Sticky clients
    ruled.client.append_rule({
        rule_any = { name = { "Picture in picture" }, instance = { "magnifiqus", "rofi", "onboard" } },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            titlebars_enabled = false,
        },
    })
    -- No border
    ruled.client.append_rule({
        rule_any = { instance = "conky" },
        properties = {
            border_width = dpi(0),
        },
    })
    -- No titlebar
    ruled.client.append_rule({
        rule_any = { instance = { "telegram", "google-chrome", "steam", "code" } },
        properties = {
            titlebars_enabled = false,
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
        rule_any = { instance = {}, class = { "Spotify", "mpv" } },
        properties = { tag = tag_name[6] },
    })
    ruled.client.append_rule({
        rule_any = {
            instance = {
                "postman",
                "DBeaver",
                "VirtualBox",
                "simple-scan",
                "gucharmap",
                "inkscape",
                "gimp",
                "qbittorrent",
            },
        },
        properties = { tag = tag_name[7] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "telegram", "discord" }, class = { "thunderbird" } },
        properties = { tag = tag_name[8] },
    })
    ruled.client.append_rule({
        rule_any = { instance = { "steam" }, class = { "Minecraft.*" } },
        properties = { tag = tag_name[9] },
    })
    ruled.client.append_rule({
        rule_any = {
            instance = {
                "nvidia-settings",
                "lxappearance",
                "pavucontrol",
                "qt5ct",
                "nitrogen",
                "arandr",
                "nm-connection-editor",
                "nm-applet",
                "blueman",
                "lshw",
                "seahorse",
            },
        },
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
