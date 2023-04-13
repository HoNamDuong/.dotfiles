-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
naughty.config.defaults["icon_size"] = 100
-- Util customize
local util = require("util")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
local terminal = os.getenv("TERMINAL")
local editor = os.getenv("EDITOR")
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
local modkey = "Mod4"
local altkey = "Mod1"

-- Tags
local tag1 = "   Terminal "
local tag2 = "   Code "
local tag3 = "   Chromium "
local tag4 = "   Files "
local tag5 = "   Documents "
local tag6 = "   Media "
local tag7 = "   Design "
local tag8 = "   Chat "
local tag9 = "   Game "
local tag0 = "   General "

-- Set the Menubar terminal for applications that require it
menubar.utils.terminal = terminal
-- }}}

-- {{{ Menu
-- Create a main menu
awful.util.mymainmenu = util.menu_build({
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
                { "Manual", terminal .. " -e man awesome" },
                { "Edit config", editor_cmd .. " " .. awesome.conffile },
                { "Reload", awesome.restart },
            },
            beautiful.awesome_icon,
        },
    },
    after = {
        { "Terminal", terminal },
        {
            "Log out",
            function()
                awesome.quit()
            end,
        },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shut down", "systemctl poweroff" },
    },
})

-- awful.util.mymainmenu = awful.menu({
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
--                 { "Manual", terminal .. " -e man awesome" },
--                 { "Edit config", editor_cmd .. " " .. awesome.conffile },
--                 { "Reload", awesome.restart },
--             },
--             beautiful.awesome_icon,
--         },
--         { "Terminal", terminal },
--         {
--             "Log out",
--             function()
--                 awesome.quit()
--             end,
--         },
--         { "Sleep", "systemctl suspend" },
--         { "Restart", "systemctl reboot" },
--         { "Shut down", "systemctl poweroff" },
--     },
-- })

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
        awful.layout.suit.floating,
    })
end)
-- }}}

-- {{{ Wibar
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, tag9, tag0 }, s, awful.layout.layouts[1])

    -- Taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({}, 1, function(t)
                t:view_only()
            end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end),
        },
    })

    -- Tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate({ context = "tasklist", action = "toggle_minimization" })
            end),
            awful.button({}, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
            end),
            awful.button({}, 4, function()
                awful.client.focus.byidx(-1)
            end),
            awful.button({}, 5, function()
                awful.client.focus.byidx(1)
            end),
        },
        layout = { layout = wibox.layout.fixed.horizontal },
        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget = wibox.container.margin,
                },
                left = 5,
                right = 5,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })

    -- Layout list
    s.mylayoutlist = {
        layout = wibox.layout.fixed.horizontal,
        awful.widget.layoutlist({
            widget_template = {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = 4,
                    widget = wibox.container.margin,
                },
                id = "background_role",
                widget = wibox.container.background,
            },
        }),
    }

    -- Promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Launcher
    s.mylauncher = awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = awful.util.mymainmenu,
    })

    -- Text clock
    s.mytextclock = wibox.widget.textclock(" %A %d/%m/%Y %H:%M ")

    -- System tray
    s.mysystray = wibox.widget.systray()

    -- Music player
    local myplayer_text = wibox.widget.textbox()
    awful.spawn.with_line_callback("playerctl --follow metadata --format ' {{ uc(playerName) }} <{{status}}>{{ duration(position) }}:{{ duration(mpris:length) }} {{artist}}|{{title}}'", {
        stdout = function(line)
            myplayer_text:set_text(line:gsub("<Playing>", "  "):gsub("<.+>", "  "))
        end,
    })
    s.myplayer = wibox.widget({
        widget = myplayer_text,
        buttons = {
            awful.button({}, 1, function()
                awful.spawn("playerctl previous")
            end),
            awful.button({}, 2, function()
                awful.spawn("playerctl play-pause")
            end),
            awful.button({}, 3, function()
                awful.spawn("playerctl next")
            end),
            -- awful.button({}, 4, function()
            --     awful.spawn(("playerctl position %f%s"):format(10, "+"))
            -- end),
            -- awful.button({}, 5, function()
            --     awful.spawn(("playerctl position %f%s"):format(10, "-"))
            -- end),
        },
    })

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        -- height = 24,
        screen = s,
        widget = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            { -- Middle widget
                layout = wibox.layout.fixed.horizontal,
                s.mytasklist,
                s.myplayer,
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                s.mysystray,
                s.mytextclock,
                s.mylayoutlist,
            },
        },
    })
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function()
        awful.util.mymainmenu:toggle()
    end),
    -- awful.button({}, 4, awful.tag.viewprev),
    -- awful.button({}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings
-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "w", function()
        awful.util.mymainmenu:show()
    end, { description = "show main menu", group = "awesome" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey }, "x", function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval",
        })
    end, { description = "lua execute prompt", group = "awesome" }),
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "r", function()
        -- awful.screen.focused().mypromptbox:run()
        awful.spawn("launchers run")
    end, { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "p", function()
        -- menubar.show()
        awful.spawn("launchers")
    end, { description = "show the menubar", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "grave", awful.tag.history.restore, { description = "go back", group = "tag" }),
    -- Non-empty tag browsing Super+Tab (Super+Shift+Tab)
    awful.key({ modkey }, "Tab", function()
        util.tag_view_nonempty(1)
    end, { description = "View next nonempty", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Tab", function()
        util.tag_view_nonempty(-1)
    end, { description = "View previous nonempty", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),
    -- awful.key({ altkey }, "Tab", function()
    --     awful.client.focus.history.previous()
    --     if client.focus then
    --         client.focus:raise()
    --     end
    --     -- local c = awful.client.focus.history.list[2]
    --     -- client.focus = c
    --     -- local t = client.focus and client.focus.first_tag or nil
    --     -- if t then
    --     --     t:view_only()
    --     -- end
    --     -- c:raise()
    -- end, { description = "go back", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),
    -- awful.key({ modkey }, "space", function()
    --     awful.layout.inc(1)
    -- end, { description = "select next", group = "layout" }),
    -- awful.key({ modkey, "Shift" }, "space", function()
    --     awful.layout.inc(-1)
    -- end, { description = "select previous", group = "layout" }),
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { modkey },
        keygroup = "numrow",
        description = "only view tag",
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
        modifiers = { modkey, "Control" },
        keygroup = "numrow",
        description = "toggle tag",
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
        modifiers = { modkey, "Shift" },
        keygroup = "numrow",
        description = "move focused client to tag",
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
        modifiers = { modkey, "Control", "Shift" },
        keygroup = "numrow",
        description = "toggle focused client on tag",
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
    --     description = "select layout directly",
    --     group = "layout",
    --     on_press = function(index)
    --         local t = awful.screen.focused().selected_tag
    --         if t then
    --             t.layout = t.layouts[index] or t.layout
    --         end
    --     end,
    -- }),
})

-- Tags related keybindings
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        awful.button({ modkey }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey }, "q", function(c)
            c:kill()
        end, { description = "close", group = "client" }),
        awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
        awful.key({ modkey, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "move to master", group = "client" }),
        awful.key({ modkey }, "o", function(c)
            c:move_to_screen()
        end, { description = "move to screen", group = "client" }),
        awful.key({ modkey }, "t", function(c)
            c.ontop = not c.ontop
        end, { description = "toggle keep on top", group = "client" }),
        awful.key({ modkey }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ modkey, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }),
    })
end)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
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
                "copyq",
                "pinentry",
                "pavucontrol",
                "nvidia-settings",
                "lxappearance",
                "qt5ct",
                "nitrogen",
                "viewnior",
                "obsidian",
                "system-config-printer",
            },
            class = {},
            name = {
                "Picture in picture",
                "Event Tester", -- xev.
            },
            role = {},
        },
        properties = { floating = true },
    })
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule({ id = "titlebars", rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } })
    -- Applications
    ruled.client.append_rule({ rule = { instance = "code" }, properties = { screen = 1, tag = tag2 } })
    ruled.client.append_rule({ rule = { instance = "nemo" }, properties = { tag = tag4 } })
    ruled.client.append_rule({ rule = { instance = "postman" }, properties = { tag = tag5 } })
    ruled.client.append_rule({ rule = { instance = "DBeaver" }, properties = { tag = tag5 } })
    ruled.client.append_rule({ rule = { instance = "mpv" }, properties = { tag = tag6 } })
    ruled.client.append_rule({ rule = { instance = "telegram" }, properties = { tag = tag8 } })
    ruled.client.append_rule({ rule = { instance = "discord" }, properties = { tag = tag8 } })
    ruled.client.append_rule({ rule = { class = "thunderbird" }, properties = { tag = tag8 } })
    ruled.client.append_rule({ rule = { class = "Minecraft" }, properties = { tag = tag9 } })
    ruled.client.append_rule({ rule = { instance = "conky" }, properties = { border_width = 0 } })
    ruled.client.append_rule({ rule = { role = "browser" }, properties = { tag = tag3, border_width = 1 } })
end)
-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({}, 1, function()
            c:activate({ context = "titlebar", action = "mouse_move" })
        end),
        awful.button({}, 3, function()
            c:activate({ context = "titlebar", action = "mouse_resize" })
        end),
    }

    awful.titlebar(c, {
        -- size = 24
    }).widget = {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Title
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    }
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

-- Focus urgent clients automatically
client.connect_signal("property::urgent", function(c)
    c.minimized = false
    c:jump_to()
end)

-- -- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", { raise = false })
-- end)

local layoutlist = awful.widget.layoutlist({
    widget_template = {
        {
            {
                id = "icon_role",
                forced_height = 50,
                forced_width = 50,
                widget = wibox.widget.imagebox,
            },
            margins = 4,
            widget = wibox.container.margin,
        },
        id = "background_role",
        forced_width = 60,
        forced_height = 60,
        widget = wibox.container.background,
    },
})

local layout_popup = awful.popup({
    widget = layoutlist,
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
})

-- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
-- keybindings before adding this.
awful.keygrabber({
    start_callback = function()
        layout_popup.visible = true
    end,
    stop_callback = function()
        layout_popup.visible = false
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = { "Escape", "Super_L", "Super_R" },
    keybindings = {
        {
            { modkey },
            " ",
            function()
                awful.layout.set((gears.table.cycle_value(layoutlist.layouts, layoutlist.current_layout, 1)))
            end,
        },
        {
            { modkey, "Shift" },
            " ",
            function()
                awful.layout.set((gears.table.cycle_value(layoutlist.layouts, layoutlist.current_layout, -1)), nil)
            end,
        },
    },
})
