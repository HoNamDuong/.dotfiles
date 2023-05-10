local awful = require("awful")

local taglist = function(s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({}, 1, function(t)
                t:view_only()
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end),
        },
    })
end

return taglist
