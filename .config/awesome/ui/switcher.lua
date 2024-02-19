local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local utils = require("utils")
local keys = require("config").keys

local switcher = nil

local function get_items()
    local items = {}

    for _, c in ipairs(awful.client.focus.history.list) do
        local tag = c:tags()[1]
        local name = " TAG " .. (tag.name or "") .. " CLIENT " .. (c.class or "") .. "\n TITLE " .. (c.name or "")

        items[#items + 1] = {
            name,
            function()
                if not c.valid then
                    return
                end
                if c.hidden then
                    c.hidden = false
                end
                if not c:isvisible() then
                    awful.tag.viewmore(c:tags(), c.screen)
                end
                c:emit_signal("request::activate", "switcher", { raise = true })
                -- Focus screen when switch clients
                awful.screen.focus(c.screen)
            end,
            -- c.icon,
            utils.get_icon_client(c),
        }
    end

    return items
end

local function toggle()
    if switcher and switcher.wibox.visible then
        local sel = switcher.sel or 0
        switcher:exec(sel)
        switcher:hide()
        switcher = nil
    else
        local workarea = awful.screen.focused().workarea

        local items = get_items()
        switcher = awful.menu({
            items = items,
            theme = {
                width = dpi(6) * 10 * 10,
                height = dpi(6) * 10,
                font = beautiful.font,
            },
        })
        switcher:show({
            coords = {
                x = ((workarea.width - switcher.width) / 2) + workarea.x,
                y = ((workarea.height - switcher.height) / 2) + workarea.y,
            },
        })
        switcher:item_enter(1)
    end
end

local function select_next()
    if switcher and switcher.wibox.visible then
        local sel = switcher.sel or 0
        local sel_new = sel + 1 > #switcher.items and 1 or sel + 1
        switcher:item_enter(sel_new)
    end
end

local function select_previous()
    if switcher and switcher.wibox.visible then
        local sel = switcher.sel or 0
        local sel_new = sel - 1 < 1 and #switcher.items or sel - 1
        switcher:item_enter(sel_new)
    end
end

-- Switch client
awful.keygrabber({
    start_callback = function()
        toggle()
    end,
    stop_callback = function()
        toggle()
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = { "Escape", "Alt_L", "Alt_R" },
    keybindings = {
        {
            { keys.alt },
            "Tab",
            function()
                select_next()
            end,
            { description = "Select next client", group = "client" },
        },
        {
            { keys.alt, "Shift" },
            "Tab",
            function()
                select_previous()
            end,
            { description = "Select previous client", group = "client" },
        },
    },
})
