local awesome, client, screen, root = awesome, client, screen, root
local globalkeys, clientkeys, string, os, tostring = globalkeys, clientkeys, string, os, tostring

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100

local freedesktop = require("freedesktop")

local menubar = require("menubar")

local lain = require("lain")
local markup = lain.util.markup

local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
beautiful.icon_theme = "Papirus-Dark"

-- This is used later as the default terminal and editor to run.
local terminal = os.getenv("TERMINAL") or "xterm"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
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
local tag9 = "   General "
local tag10 = "   Settings "

-- Set the Menubar terminal for applications that require it
menubar.utils.terminal = terminal

awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,

    -- lain.layout.centerwork,
    -- lain.layout.cascade,
}
-- }}}

awful.util.mymainmenu = freedesktop.menu.build({
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

-- {{{ Wibar
local taglist_buttons = gears.table.join(
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
    end)
    -- awful.button({}, 4, function(t)
    --     awful.tag.viewnext(t.screen)
    -- end),
    -- awful.button({}, 5, function(t)
    --     awful.tag.viewprev(t.screen)
    -- end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 2, function(c)
        c:kill()
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end)
    -- awful.button({}, 4, function()
    --     awful.client.focus.byidx(1)
    -- end),
    -- awful.button({}, 5, function()
    --     awful.client.focus.byidx(-1)
    -- end)
)

-- MEM
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. mem_now.perc .. "% "))
    end,
    timeout = 1,
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. cpu_now.usage .. "% "))
    end,
    timeout = 1,
})

-- ALSA volume
local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup.font(beautiful.font, " 婢 muted "))
        else
            widget:set_markup(markup.font(beautiful.font, "  " .. volume_now.level .. "% "))
        end
    end,
    timeout = 1,
    channel = "Master",
})

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, tag9, tag10 }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 26,
    })

    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        -- expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.launcher({
                image = beautiful.awesome_icon,
                menu = awful.util.mymainmenu,
            }),
            awful.widget.taglist({
                screen = s,
                filter = awful.widget.taglist.filter.noempty,
                buttons = taglist_buttons,
            }),
            s.mypromptbox,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            awful.widget.tasklist({
                screen = s,
                filter = awful.widget.tasklist.filter.currenttags,
                buttons = tasklist_buttons,
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
            }),
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            -- awful.widget.watch('bash -c "exec nvidia-smi -i 0 -q -d MEMORY |grep "Used" | cut -c 45-55 | head -1"'),
            volume.widget,
            wibox.widget({
                markup = " <span foreground='#1abc9c'>GPU</span>",
                widget = wibox.widget.textbox,
            }),
            awful.widget.watch('bash -c "nvidia-smi -i 0 | grep % | cut -c 61-64"', 1),
            awful.widget.watch('bash -c "nvidia-smi -i 0 | grep % | cut -c 8-12"', 1),
            wibox.widget({
                markup = " <span foreground='#bb9af7'>MEM</span>",
                widget = wibox.widget.textbox,
            }),
            mem.widget,
            wibox.widget({
                markup = " <span foreground='#7aa2f7'>CPU</span>",
                widget = wibox.widget.textbox,
            }),
            cpu.widget,
            wibox.widget.textclock(" %A %d/%m/%Y %H:%M "),
            {
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
            },
        },
    })
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function()
        awful.util.mymainmenu:toggle()
    end)
    -- awful.button({}, 4, awful.tag.viewnext),
    -- awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Tag
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "Go back", group = "tag" }),

    -- Non-empty tag browsing SUPER+TAB (SUPER+SHIFT+TAB)
    awful.key({ modkey }, "Tab", function()
        lain.util.tag_view_nonempty(1)
    end, { description = "View next nonempty", group = "tag" }),

    awful.key({ modkey, "Shift" }, "Tab", function()
        lain.util.tag_view_nonempty(-1)
    end, { description = "View previous nonempty", group = "tag" }),

    -- Screen
    awful.key({ modkey, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, { description = "Focus the next screen", group = "screen" }),

    awful.key({ modkey, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, { description = "Focus the previous screen", group = "screen" }),

    --Awesome
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "Show help", group = "awesome" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "Reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "Quit awesome", group = "awesome" }),

    awful.key({ modkey }, "x", function()
        awful.util.mymainmenu:toggle()
    end, { description = "Show main menu", group = "awesome" }),

    -- awful.key({ modkey }, "x", function()
    --     awful.prompt.run({
    --         prompt = "Run Lua code: ",
    --         textbox = awful.screen.focused().mypromptbox.widget,
    --         exe_callback = awful.util.eval,
    --         history_path = awful.util.get_cache_dir() .. "/history_eval",
    --     })
    -- end, { description = "lua execute prompt", group = "awesome" }),

    -- Standard program and Prompt
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "Open a terminal", group = "launcher" }),

    awful.key({ modkey }, "r", function()
        awful.spawn.with_shell("~/.config/rofi/bin/launcher")
    end, { description = "Run prompt", group = "launcher" }),

    awful.key({ modkey }, "d", function()
        awful.util.spawn("dmenu_run -fn 'Hack Nerd Font-14' -nf '#c8d3f5' -nb '#1a1b26' -sf '#c8d3f5' -sb '#3b4261'")
        -- awful.screen.focused().mypromptbox:run()
    end, { description = "Run prompt", group = "launcher" }),

    awful.key({ modkey }, "p", function()
        awful.spawn.with_shell("~/.config/rofi/bin/apps")
    end, { description = "Applications", group = "launcher" }),

    awful.key({}, "Print", function()
        awful.spawn.with_shell("gnome-screenshot")
    end, { description = "Screenshot", group = "launcher" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "Swap with next client by index", group = "layout" }),

    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, { description = "Swap with previous client by index", group = "layout" }),

    awful.key({ modkey }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "Increase master width factor", group = "layout" }),

    awful.key({ modkey }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "Decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "Increase the number of master clients", group = "layout" }),
    --
    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "Decrease the number of master clients", group = "layout" }),

    awful.key({ modkey, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "Increase the number of columns", group = "layout" }),
    --
    awful.key({ modkey, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "Decrease the number of columns", group = "layout" }),

    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "Select next", group = "layout" }),

    awful.key({ modkey, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, { description = "Select previous", group = "layout" }),

    -- Client
    awful.key({ modkey }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),

    awful.key({ modkey }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

    awful.key({ altkey }, "Tab", function()
        awful.spawn.with_shell("~/.config/rofi/bin/windows")
    end, { description = "list windows", group = "client" }),

    -- awful.key({ altkey }, "Tab", function()
    --     awful.client.focus.byidx(-1)
    --     if client.focus then
    --         client.focus:raise()
    --     end
    -- end),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "Restore minimized", group = "client" })
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "client" }),

    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "Toggle fullscreen", group = "client" }),

    awful.key({ modkey }, "q", function(c)
        c:kill()
    end, { description = "Close client", group = "client" }),

    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "Move to master", group = "client" }),

    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, { description = "Move to screen", group = "client" }),

    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "Toggle keep on top", group = "client" }),

    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "Minimize", group = "client" }),

    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "(Un)maximize", group = "client" }),

    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = "(Un)maximize vertically", group = "client" }),

    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, { description = "(Un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    globalkeys = gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = "View tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = "Toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, { description = "Move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = "Toggle focused client on tag #" .. i, group = "tag" })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
                "nvidia-settings",
                "pavucontrol",
                "lxappearance",
                "nitrogen",
                "feh",
                "conky",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Picture in picture",
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        },
    },

    { rule = { role = "browser" }, properties = { tag = tag3, border_width = 0 } },
    { rule = { instance = "code" }, properties = { tag = tag2 } },
    { rule = { instance = "nemo" }, properties = { tag = tag4 } },
    { rule = { instance = "telegram" }, properties = { tag = tag8 } },
    { rule = { instance = "discord" }, properties = { tag = tag8 } },
    { rule = { instance = "conky" }, properties = { border_width = 0 } },

    -- Add titlebars to normal clients and dialogs
    -- { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = beautiful.menu_height }):setup({
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            buttons = buttons,
            awful.titlebar.widget.iconwidget(c),
        },
        { -- Middle
            layout = wibox.layout.flex.horizontal,
            buttons = buttons,
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal(),
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
        },
    })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- Focus urgent clients automatically
client.connect_signal("property::urgent", function(c)
    c.minimized = false
    c:jump_to()
end)

-- -- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", { raise = false })
-- end)

-- -- No border for single clients
-- screen.connect_signal("arrange", function(s)
--     local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--         if only_one and not c.floating or c.maximized then
--             c.border_width = 0
--         else
--             c.border_width = beautiful.border_width -- your border width
--         end
--     end
-- end)

-- }}}

-- Autostart Applications
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("nvidia-settings --load-config-only")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("numlockx")
awful.spawn.with_shell("ibus-daemon --xim -d -r")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
-- awful.spawn.with_shell("picom")
