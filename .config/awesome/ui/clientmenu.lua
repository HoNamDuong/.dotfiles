local beautiful = require("beautiful")
local awful = require("awful")
local aclient = require("awful.client")

local clientmenu = {
    widget = nil,
}

local item_names = {
    close = "Close",
    minimize = "Minimize",
    maximized_active = "Unmaximize",
    maximized_inactive = "Maximize",
    floating_active = "Tiling",
    floating_inactive = "Floating",
    ontop_active = "NotOnTop",
    ontop_inactive = "OnTop",
    sticky_active = "NotSticky",
    sticky_inactive = "Sticky",
}

local function build_item(c, name, selector, action)
    local item = {
        name = nil,
        icon = nil,
        action = action,
    }

    local img = selector(c)
    if type(img) ~= "nil" then
        if type(img) == "boolean" then
            if img then
                img = "active"
            else
                img = "inactive"
            end
        end

        local prefix = "normal"
        if c.active then
            prefix = "focus"
        end

        if img ~= "" then
            prefix = prefix .. "_"
        end

        item.name = item_names[name .. "_" .. img] or item_names[name] or name

        item.icon = beautiful["titlebar_" .. name .. "_button_" .. prefix .. img]
    end

    return { item.name, item.action, item.icon }
end

local function build_menu(c)
    local floating_buttom = build_item(c, "floating", aclient.object.get_floating, function()
        c.floating = not c.floating
    end)

    local close_buttom = build_item(c, "close", function()
        return ""
    end, function()
        c:kill()
    end)

    local minimize_buttom = build_item(c, "minimize", function()
        return ""
    end, function()
        c.minimized = not c.minimized
    end)

    local maximized_buttom = build_item(c, "maximized", function()
        return c.maximized
    end, function()
        c.maximized = not c.maximized
    end)

    local ontop_buttom = build_item(c, "ontop", function()
        return c.ontop
    end, function()
        c.ontop = not c.ontop
    end)

    local sticky_buttom = build_item(c, "sticky", function()
        return c.sticky
    end, function()
        c.sticky = not c.sticky
    end)

    local menu = awful.menu({
        items = {
            ontop_buttom,
            sticky_buttom,
            floating_buttom,
            not c.minimized and minimize_buttom,
            maximized_buttom,
            close_buttom,
        },
        theme = {
            -- border_color = c.active and beautiful.common.primary,
        },
    })

    menu:show()

    return menu
end

function clientmenu:toggle(c)
    if self.widget and self.widget.wibox.visible then
        self.widget:hide()
        self.widget = nil
    else
        self.widget = build_menu(c)
    end
    return self
end

return clientmenu
