local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local switcher = { widget = nil }

local function build_menu()
    local items = {}

    local function add_client(c)
        local tag = c:tags()[1]

        local name = (tag.name or "") .. " " .. (c.class or "") .. " | " .. (c.name or "")

        items[#items + 1] = {
            name,
            function()
                if not c.valid then
                    return
                end
                if not c:isvisible() then
                    awful.tag.viewmore(c:tags(), c.screen)
                end
                c:emit_signal("request::activate", "switcher", { raise = true })
            end,
            c.icon,
        }
    end

    for _, client in ipairs(awful.client.focus.history.list) do
        add_client(client)
    end

    local menu_width = dpi(60) * 6

    local m = awful.menu({
        items = items,
        theme = {
            width = menu_width,
            height = dpi(6) * 8,
            font = beautiful.font,
        },
    })

    local s = awful.screen.focused().workarea

    m:show({
        coords = {
            x = (s.width / 2) - (menu_width / 2),
            y = (s.height / 2) - (m.height / 2),
        },
    })

    return m
end

function switcher:toggle()
    if self.widget and self.widget.wibox.visible then
        local sel = self.widget.sel or 0
        self.widget:hide()
        self.widget:exec(sel)
        self.widget = nil
    else
        self.widget = build_menu()
        self.widget:item_enter(1)
    end
    return self
end

function switcher:select_next()
    if self.widget and self.widget.wibox.visible then
        local sel = self.widget.sel or 0
        local sel_new = sel + 1 > #self.widget.items and 1 or sel + 1
        self.widget:item_enter(sel_new)
    end
end

function switcher:select_previous()
    if self.widget and self.widget.wibox.visible then
        local sel = self.widget.sel or 0
        local sel_new = sel - 1 < 1 and #self.widget.items or sel - 1
        self.widget:item_enter(sel_new)
    end
end

return switcher
