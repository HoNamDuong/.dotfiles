local config = require("config")
local beautiful = require("beautiful")
local menu = require("awful.menu")
local menu_gen = require("menubar.menu_gen")
local hotkeys = require("ui.hotkeys")

-- Add other category
menu_gen.all_categories.other = { app_type = "Other", name = "Other", icon_name = "applications-other", use = false }

-- Source https://github.com/lcpz/awesome-freedesktop
-- Use MenuBar parsing utils to build a menu for Awesome
local function build_menu(args)
    local before = args.before or {}
    local after = args.after or {}

    local result = {}
    local _menu = menu({ items = before })

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
        for _, v in pairs(result) do
            _menu:add(v)
        end
        for _, v in pairs(after) do
            _menu:add(v)
        end
    end)

    return _menu
end

local mainmenu = build_menu({
    sub_menu = "Applications",
    before = {
        {
            "Awesome",
            {
                {
                    "Hotkeys",
                    function()
                        hotkeys:show_help()
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
        { "Restart", config.actions.restart, beautiful.restart_icon },
        { "Shutdown", config.actions.shutdown, beautiful.shutdown_icon },
    },
})

return mainmenu
