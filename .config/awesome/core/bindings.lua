local awful = require("awful")
local menubar = require("menubar")
local naughty = require("naughty")
local util = require("util")

local mainmenu = require("ui.menu.mainmenu")
local promptbox = require("ui.wibar.prompt")
local layoutlist = require("ui.popup.layoutlist")
local hotkeys = require("ui.popup.hotkeys")

local apps = require("config").apps
local keys = require("config").keys

-- {{{ Mouse bindings
-- Global
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function()
        mainmenu:toggle()
    end),
    -- awful.button({}, 4, awful.tag.viewprev),
    -- awful.button({}, 5, awful.tag.viewnext),
})

-- Clinet
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        awful.button({ keys.super }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        awful.button({ keys.super }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)
-- }}}

-- {{{ Key bindings
-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "s", function()
        hotkeys:show_help()
    end, { description = "Show help", group = "awesome" }),

    awful.key({ keys.super }, "w", function()
        mainmenu:show()
    end, { description = "Show main menu", group = "awesome" }),

    awful.key({ keys.super, "Control" }, "r", awesome.restart, { description = "Reload awesome", group = "awesome" }),

    awful.key({ keys.super, "Shift" }, "q", awesome.quit, { description = "Quit awesome", group = "awesome" }),

    -- awful.key({ modkey }, "a", function()
    --     awful.prompt.run({
    --         prompt = "Run Lua code: ",
    --         textbox = promptbox.widget,
    --         exe_callback = awful.util.eval,
    --         history_path = awful.util.get_cache_dir() .. "/history_eval",
    --     })
    -- end, { description = "Lua execute prompt", group = "awesome" }),

    awful.key({ keys.super }, "x", function()
        awful.spawn("powermenu")
    end, { description = "Power menu", group = "awesome" }),

    awful.key({ keys.super }, "r", function()
        -- promptbox:run()
        awful.spawn("launchers run")
    end, { description = "Run prompt", group = "launcher" }),

    awful.key({ keys.super }, "p", function()
        -- menubar.show()
        awful.spawn("launchers")
    end, { description = "Show the launcher", group = "launcher" }),

    awful.key({ keys.super }, "Return", function()
        awful.spawn(apps.terminal)
    end, { description = "Terminal", group = "launcher" }),

    awful.key({ keys.super }, "b", function()
        awful.spawn(apps.browser)
    end, { description = "Browser", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "Right", awful.tag.viewnext, { description = "View next tag", group = "tag" }),

    awful.key({ keys.super }, "Left", awful.tag.viewprev, { description = "View previous tag", group = "tag" }),

    awful.key({ keys.super }, "grave", awful.tag.history.restore, { description = "Go back tag", group = "tag" }),

    -- Non-empty tag browsing Super+Tab (Super+Shift+Tab)
    awful.key({ keys.super }, "Tab", function()
        util.tag_view_nonempty(1)
    end, { description = "View next nonempty tag", group = "tag" }),

    awful.key({ keys.super, "Shift" }, "Tab", function()
        util.tag_view_nonempty(-1)
    end, { description = "View previous nonempty tag", group = "tag" }),
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { keys.super },
        keygroup = "numrow",
        description = "Only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),

    awful.key({
        modifiers = { keys.super, "Control" },
        keygroup = "numrow",
        description = "Toggle tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    }),

    awful.key({
        modifiers = { keys.super, "Shift" },
        keygroup = "numrow",
        description = "Move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end,
    }),

    awful.key({
        modifiers = { keys.super, "Control", "Shift" },
        keygroup = "numrow",
        description = "Toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    }),

    -- awful.key({
    --     modifiers = { modkey },
    --     keygroup = "numpad",
    --     description = "Select layout directly",
    --     group = "layout",
    --     on_press = function(index)
    --         local t = awful.screen.focused().selected_tag
    --         if t then
    --             t.layout = t.layouts[index] or t.layout
    --         end
    --     end,
    -- }),
})

-- Client related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "Focus next by index", group = "client" }),

    awful.key({ keys.super }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "Focus previous by index", group = "client" }),

    awful.key({ keys.alt }, "Tab", function()
        -- awful.client.focus.history.previous()
        -- if client.focus then
        --     client.focus:raise()
        -- end
        local c = awful.client.focus.history.list[2]
        client.focus = c
        local t = client.focus and client.focus.first_tag or nil
        if t then
            t:view_only()
        end
    end, { description = "Go back client", group = "client" }),

    awful.key({ keys.super, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "Restore minimized", group = "client" }),
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ keys.super }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "Toggle fullscreen", group = "client" }),

        awful.key({ keys.super }, "q", function(c)
            c:kill()
        end, { description = "Close", group = "client" }),

        awful.key({ keys.super, "Control" }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "client" }),

        awful.key({ keys.super, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "Move to master", group = "client" }),

        awful.key({ keys.super }, "o", function(c)
            c:move_to_screen()
        end, { description = "Move to screen", group = "client" }),

        awful.key({ keys.super }, "t", function(c)
            c.ontop = not c.ontop
        end, { description = "Toggle keep on top", group = "client" }),

        awful.key({ keys.super }, "i", function(c)
            c.sticky = not c.sticky
        end, { description = "Toggle sticky", group = "client" }),

        awful.key({ keys.super }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "Minimize", group = "client" }),

        awful.key({ keys.super }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ keys.super, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ keys.super, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }),
    })
end)

-- Screen related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, { description = "Focus the next screen", group = "screen" }),

    awful.key({ keys.super, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, { description = "Focus the previous screen", group = "screen" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "Swap with next client by index", group = "client" }),

    awful.key({ keys.super, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, { description = "Swap with previous client by index", group = "client" }),

    awful.key({ keys.super }, "u", awful.client.urgent.jumpto, { description = "Jump to urgent client", group = "client" }),

    awful.key({ keys.super }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "Increase master width factor", group = "layout" }),

    awful.key({ keys.super }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "Decrease master width factor", group = "layout" }),

    awful.key({ keys.super, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "Increase the number of master clients", group = "layout" }),

    awful.key({ keys.super, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "Decrease the number of master clients", group = "layout" }),

    awful.key({ keys.super, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "Increase the number of columns", group = "layout" }),

    awful.key({ keys.super, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "Decrease the number of columns", group = "layout" }),

    -- awful.key({ modkey }, "space", function()
    --     awful.layout.inc(1)
    -- end, { description = "Select next", group = "layout" }),

    -- awful.key({ modkey, "Shift" }, "space", function()
    --     awful.layout.inc(-1)
    -- end, { description = "Select previous", group = "layout" }),
})

-- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
awful.keygrabber({
    start_callback = function()
        layoutlist.visible = true
    end,
    stop_callback = function()
        layoutlist.visible = false
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = { "Escape", "Super_L", "Super_R" },
    keybindings = {
        {
            { keys.super },
            " ",
            function()
                awful.layout.inc(1)
            end,
            {
                description = "Select next layout",
                group = "layout",
            },
        },
        {
            { keys.super, "Shift" },
            " ",
            function()
                awful.layout.inc(-1)
            end,
            {
                description = "Select previous layout",
                group = "layout",
            },
        },
    },
})

-- }}}

-- TEST
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "F1", function()
        naughty.notification({
            title = "Test low",
            text = "this is test low notification",
            urgency = "low",
        })
    end, { description = "send test low notification", group = "test" }),

    awful.key({ keys.super }, "F2", function()
        naughty.notification({
            title = "Test normal",
            text = "this is test normal notification",
            urgency = "normal",
            actions = {
                naughty.action({
                    name = "Accept",
                }),
                naughty.action({
                    name = "Refuse",
                }),
                naughty.action({
                    name = "Ignore",
                }),
            },
        })
    end, { description = "send test notification", group = "test" }),

    awful.key({ keys.super }, "F3", function()
        naughty.notification({
            title = "Test critical",
            text = "this is test critical notification",
            urgency = "critical",
        })
    end, { description = "send test critical notification", group = "test" }),
})
