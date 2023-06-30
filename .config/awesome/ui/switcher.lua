local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("config").keys
local dpi = require("beautiful.xresources").apply_dpi

local clients_menu = nil

local function get_items()
    local items = {}

    for _, c in ipairs(awful.client.focus.history.list) do
        local tag = c:tags()[1]
        local name = (tag.name or "") .. " | " .. (c.class or "") .. " | " .. (c.name or "")

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
            end,
            c.icon,
        }
    end

    return items
end

local function toggle()
    if clients_menu and clients_menu.wibox.visible then
        local sel = clients_menu.sel or 0
        clients_menu:exec(sel)
        clients_menu:hide()
        clients_menu = nil
    else
        local workarea = awful.screen.focused().workarea
        local items = get_items()
        clients_menu = awful.menu({
            items = items,
            theme = {
                width = dpi(6) * 10 * 6,
                height = dpi(6) * 8,
                font = beautiful.font,
            },
        })
        clients_menu:show({
            coords = {
                x = (workarea.width - clients_menu.width) / 2,
                y = (workarea.height - clients_menu.height) / 2,
            },
        })
        clients_menu:item_enter(1)
    end
end

local function select_next()
    if clients_menu and clients_menu.wibox.visible then
        local sel = clients_menu.sel or 0
        local sel_new = sel + 1 > #clients_menu.items and 1 or sel + 1
        clients_menu:item_enter(sel_new)
    end
end

local function select_previous()
    if clients_menu and clients_menu.wibox.visible then
        local sel = clients_menu.sel or 0
        local sel_new = sel - 1 < 1 and #clients_menu.items or sel - 1
        clients_menu:item_enter(sel_new)
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
-- }}}
