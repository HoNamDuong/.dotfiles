local awful = require("awful")
local gstring = require("gears.string")

local utils = {
    tag = {},
    pango = {},
}

-- Source https://github.com/lcpz/lain
-- Non-empty tag browsing
-- direction in {-1, 1} <-> {previous, next} non-empty tag
function utils.tag.view_nonempty(direction, sc)
    direction = direction or 1
    local s = sc or awful.screen.focused()
    local tags = s.tags
    local sel = s.selected_tag

    if sel == nil then
        tags[1]:view_only()
        return
    end

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

---Convert lua table to pango "span".
---@param data table|string
---@param separator? string # Value separator.
---@return string
function utils.pango.span(data, separator)
    if type(data) == "table" then
        separator = separator or ""

        local t = ""
        for _, v in ipairs(data) do
            t = t .. separator .. v
        end

        local s = "<span "
        for k, v in pairs(data) do
            if type(k) ~= "number" then
                s = s .. k .. "='" .. v .. "' "
            end
        end
        return s .. ">" .. t .. "</span>"
    elseif type(data) == "string" then
        return data
    end
    return ""
end

---@param data string
---@return string
function utils.pango.escape(data)
    return gstring.xml_escape(data)
end

---@param data string
---@return string
function utils.pango.b(data)
    return "<b>" .. data .. "</b>"
end

---@param data string
---@return string
function utils.pango.i(data)
    return "<i>" .. data .. "</i>"
end

---@param data string
---@return string
function utils.pango.u(data)
    return "<u>" .. data .. "</u>"
end

return utils
