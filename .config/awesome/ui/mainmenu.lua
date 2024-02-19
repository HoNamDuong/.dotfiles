local awful = require("awful")
local beautiful = require("beautiful")
local menu_gen = require("menubar.menu_gen")

local config = require("config")
local keys = require("config").keys

-- Add other category
menu_gen.all_categories.other = { app_type = nil, name = "Other", icon_name = "applications-other", use = true }

-- Source https://github.com/lcpz/awesome-freedesktop
-- Use MenuBar parsing utils to build a menu for Awesome
local function build_menu(args)
    local before = args.before or {}
    local result = {}
    local after = args.after or {}

    local menu = awful.menu()

    menu_gen.generate(function(entries)
        -- Add category icons
        for k, v in pairs(menu_gen.all_categories) do
            table.insert(result, { k, {}, v.icon })
        end

        -- Get items table
        for _, v in pairs(entries) do
            if not v.category then
                v.category = "other"
            end
            for _, cat in pairs(result) do
                if cat[1] == v.category then
                    table.insert(cat[2], { v.name, v.cmdline, v.icon })
                    break
                end
            end
        end

        -- Cleanup things a bit
        for i = #result, 1, -1 do
            local v = result[i]
            if #v[2] == 0 then
                -- Remove unused categories
                table.remove(result, i)
            else
                -- Sort entries alphabetically (by name)
                table.sort(v[2], function(a, b)
                    return string.byte(a[1]) < string.byte(b[1])
                end)
                -- Replace category name with nice name
                v[1] = menu_gen.all_categories[v[1]].name
            end
        end

        -- Sort categories alphabetically also
        table.sort(result, function(a, b)
            return string.byte(a[1]) < string.byte(b[1])
        end)

        -- Add items to menu
        for _, v in pairs(before) do
            menu:add(v)
        end
        for _, v in pairs(result) do
            menu:add(v)
        end
        for _, v in pairs(after) do
            menu:add(v)
        end
    end)

    return menu
end

local mainmenu = build_menu({
    before = {
        {
            "Awesome",
            {
                {
                    "Hotkeys",
                    function()
                        awesome.emit_signal("hotkeys::show")
                    end,
                    beautiful.keyboard_icon,
                },
                { "Manual", config.apps.terminal .. " -e man awesome", beautiful.book_icon },
                { "Edit config", config.apps.editor .. " " .. awesome.conffile, beautiful.setting_icon },
                { "Reload", awesome.restart, beautiful.refresh_icon },
            },
            beautiful.awesome_icon,
        },
    },
    after = {
        { "Randomize wallpaper", config.actions.randomize_wallpaper, beautiful.image_icon },
        { "Take screenshot", config.actions.screenshot, beautiful.camera_icon },
        { "Switch user", config.actions.switch_user, beautiful.switch_user_icon },
        { "Lock", config.actions.lock, beautiful.lock_icon },
        { "Logout", config.actions.logout, beautiful.logout_icon },
        { "Sleep", config.actions.sleep, beautiful.sleep_icon },
        { "Hibernate", config.actions.hibernate, beautiful.hibernate_icon },
        { "Reboot", config.actions.reboot, beautiful.reboot_icon },
        { "Shutdown", config.actions.shutdown, beautiful.shutdown_icon },
    },
})

awesome.connect_signal("mainmenu::toggle", function()
    mainmenu:toggle()
end)

awful.keyboard.append_global_keybindings({
    awful.key({ keys.super }, "w", function()
        awesome.emit_signal("mainmenu::toggle")
    end, { description = "Show main menu", group = "awesome" }),
})
