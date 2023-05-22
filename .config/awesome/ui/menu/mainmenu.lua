local beautiful = require("beautiful")
local config = require("config")
local hotkeys = require("ui.popup.hotkeys")
local menu = require("awful.menu")
local menu_gen = require("menubar.menu_gen")

-- Source https://github.com/lcpz/awesome-freedesktop
-- Use MenuBar parsing utils to build a menu for Awesome
-- @return awful.menu
local function menu_build(args)
    local before = args.before or {}
    local after = args.after or {}
    local sub_menu = args.sub_menu or false

    local result = {}
    local _menu = menu({ items = before })

    menu_gen.generate(function(entries)
        -- Add category icons
        for k, v in pairs(menu_gen.all_categories) do
            table.insert(result, { k, {}, v.icon })
        end

        -- Get items table
        for k, v in pairs(entries) do
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
                --Sort entries alphabetically (by name)
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

        -- Add menu item to hold the generated menu
        if sub_menu then
            result = { { sub_menu, result } }
        end

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

local mainmenu = menu_build({
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
        { "Lock", config.power.lock, beautiful.power_lock },
        { "Logout", config.power.logout, beautiful.power_logout },
        { "Sleep", config.power.sleep, beautiful.power_sleep },
        { "Restart", config.power.restart, beautiful.power_restart },
        { "Shutdown", config.power.shutdown, beautiful.power_shutdown },
    },
})

return mainmenu
