local awful = require("awful")
local awful_menu = require("awful.menu")
local menu_gen = require("menubar.menu_gen")

local util = {}

-- Non-empty tag browsing
-- direction in {-1, 1} <-> {previous, next} non-empty tag
function util.tag_view_nonempty(direction, sc)
    direction = direction or 1
    local s = sc or awful.screen.focused()
    local tags = s.tags
    local sel = s.selected_tag

    local i = sel.index
    repeat
        i = i + direction

        -- Wrap around when we reach one of the bounds
        if i > #tags then
            i = i - #tags
        end
        if i < 1 then
            i = i + #tags
        end

        local t = tags[i]

        -- Stop when we get back to where we started
        if t == sel then
            break
        end

        -- If it's The One, view it.
        if #t:clients() > 0 then
            t:view_only()
            return
        end
    until false
end

-- Determines whether an table includes a certain element
-- @param tab a given table
-- @param val the element to search for
-- @return true if the given string is found within the search table; otherwise, false if not
function util.has_value(tab, val)
    for _, value in pairs(tab) do
        if val:find(value) then
            return true
        end
    end
    return false
end

-- Use MenuBar parsing utils to build a menu for Awesome
-- @return awful.menu
function util.menu_build(args)
    local args = args or {}
    local before = args.before or {}
    local after = args.after or {}
    local skip_items = args.skip_items or {}
    local sub_menu = args.sub_menu or false

    local result = {}
    local _menu = awful_menu({ items = before })

    menu_gen.generate(function(entries)
        -- Add category icons
        for k, v in pairs(menu_gen.all_categories) do
            table.insert(result, { k, {}, v.icon })
        end

        -- Get items table
        for k, v in pairs(entries) do
            for _, cat in pairs(result) do
                if cat[1] == v.category then
                    if not util.has_value(skip_items, v.name) then
                        table.insert(cat[2], { v.name, v.cmdline, v.icon })
                    end
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

return util
