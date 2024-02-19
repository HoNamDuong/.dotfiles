local awful = require("awful")
local naughty = require("naughty")

local utils = require("utils")
local actions = require("config").actions
local apps = require("config").apps
local keys = require("config").keys

-- {{{ Mouse bindings
-- Global
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function()
        awesome.emit_signal("mainmenu::toggle")
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
    awful.key({ keys.super, "Control" }, "r", awesome.restart, { description = "Reload awesome", group = "awesome" }),

    awful.key({ keys.super, "Shift" }, "q", awesome.quit, { description = "Quit awesome", group = "awesome" }),

    awful.key({ keys.super }, "r", function()
        -- local prompt = require("ui.wibar.prompt")
        -- awful.prompt.run({
        --     prompt = "Run Lua code: ",
        --     textbox = prompt.widget,
        --     exe_callback = awful.util.eval,
        --     history_path = awful.util.get_cache_dir() .. "/history_eval",
        -- })
        -- prompt:run()
        awful.spawn(apps.run)
    end, { description = "Open run", group = "actions" }),

    awful.key({ keys.super }, "a", function()
        -- local menubar = require("menubar")
        -- menubar.show()
        awful.spawn(apps.launcher)
    end, { description = "Open launcher", group = "actions" }),

    awful.key({ keys.super }, "Return", function()
        awful.spawn(apps.terminal)
    end, { description = "Open terminal", group = "actions" }),

    awful.key({ keys.super }, "x", function()
        awful.spawn(apps.powermenu)
    end, { description = "Open powermenu", group = "actions" }),

    awful.key({}, "Print", function()
        awful.spawn.with_shell(actions.screenshot)
    end, { description = "Take a screenshot of entire screen", group = "screenshot" }),

    awful.key({ keys.control }, "Print", function()
        awful.spawn.with_shell(actions.screenshot_window)
    end, { description = "Take a screenshot of focused window", group = "screenshot" }),

    awful.key({ keys.shift }, "Print", function()
        awful.spawn.with_shell(actions.screenshot_area)
    end, { description = "Take a screenshot of selection", group = "screenshot" }),

    awful.key({ keys.super }, "Print", function()
        awful.spawn.with_shell(actions.screenshot_delay)
        naughty.notify({
            message = "Take a screenshot of delay 5 second",
            timeout = 4.5,
        })
    end, { description = "Take a screenshot of delay", group = "screenshot" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "Right", awful.tag.viewnext, { description = "View next tag", group = "tag" }),

    awful.key({ keys.super }, "Left", awful.tag.viewprev, { description = "View previous tag", group = "tag" }),

    awful.key({ keys.super }, "grave", awful.tag.history.restore, { description = "Go back tag", group = "tag" }),

    -- Non-empty tag browsing Super+Tab (Super+Shift+Tab)
    awful.key({ keys.super }, "Tab", function()
        utils.tag.view_nonempty(1)
    end, { description = "View next nonempty tag", group = "tag" }),

    awful.key({ keys.super, "Shift" }, "Tab", function()
        utils.tag.view_nonempty(-1)
    end, { description = "View previous nonempty tag", group = "tag" }),
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { keys.super },
        keygroup = awful.key.keygroup.NUMROW,
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
        keygroup = awful.key.keygroup.NUMROW,
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
        keygroup = awful.key.keygroup.NUMROW,
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

    -- awful.key({
    --     modifiers = { keys.super, "Control", "Shift" },
    --     keygroup = awful.key.keygroup.NUMROW,
    --     description = "Toggle focused client on tag",
    --     group = "tag",
    --     on_press = function(index)
    --         if client.focus then
    --             local tag = client.focus.screen.tags[index]
    --             if tag then
    --                 client.focus:toggle_tag(tag)
    --             end
    --         end
    --     end,
    -- }),

    -- awful.key({
    --     modifiers = { keys.super },
    --     keygroup = awful.key.keygroup.NUMPAD,
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

    awful.key({ keys.super }, "g", function()
        utils.tag.toggle_gap()
    end, { description = "Toggle space between clients", group = "layout" }),
})
-- }}}

-- {{{ Test
awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "F5", function()
        local screen = awful.screen.focused()
        screen:split()
    end, { description = "Split the screen", group = "test" }),

    awful.key({ keys.super }, "F6", function()
        local screen = awful.screen.focused()
        screen:fake_remove()
    end, { description = "Remove the screen", group = "test" }),

    awful.key({ keys.super }, "F7", function()
        local screen = awful.screen.focused()
        screen:fake_resize(0, 0, 1600, 900)
    end, { description = "Resize the screen", group = "test" }),

    awful.key({ keys.super }, "F1", function()
        naughty.notify({
            title = "Low notification",
            message = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.",
            urgency = "low",
            actions = {
                naughty.action({ name = "Let's go!" }),
            },
        })
    end, { description = "Low notification", group = "test" }),

    awful.key({ keys.super }, "F2", function()
        naughty.notify({
            title = "Normal notification",
            message = "Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.",
            urgency = "normal",
            actions = {
                naughty.action({ name = "Accept" }),
                naughty.action({ name = "Refuse" }),
                naughty.action({ name = "Ignore" }),
            },
        })
    end, { description = "Normal notification", group = "test" }),

    awful.key({ keys.super }, "F3", function()
        naughty.notify({
            title = "Critical notification",
            message = "Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.",
            urgency = "critical",
            actions = {
                naughty.action({ name = "Yes" }),
                naughty.action({ name = "No" }),
            },
        })
    end, { description = "Critical notification", group = "test" }),
})
-- }}}
