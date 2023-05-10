local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local current_theme = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- local current_theme = {
--     background = "#1a1b26",
--     foreground = "#c0caf5",
--
--     color0 = "#1a1b26",
--     color1 = "#f7768e",
--     color2 = "#9ece6a",
--     color3 = "#e0af68",
--     color4 = "#7aa2f7",
--     color5 = "#bb9af7",
--     color6 = "#7dcfff",
--     color7 = "#a9b1d6",
--
--     color8 = "#414868",
--     color9 = "#f7768e",
--     color10 = "#9ece6a",
--     color11 = "#e0af68",
--     color12 = "#7aa2f7",
--     color13 = "#bb9af7",
--     color14 = "#7dcfff",
--     color15 = "#c0caf5",
-- }

local theme = {}

-- icon
theme.icon_theme = "Papirus-Dark"

-- font
theme.font = "Hack Nerd Font Mono 12"

-- bg
theme.bg_normal = current_theme.background
theme.bg_focus = current_theme.color8
theme.bg_urgent = current_theme.color9
theme.bg_minimize = current_theme.color15

theme.bg_systray = current_theme.background

-- fg
theme.fg_normal = current_theme.foreground
theme.fg_focus = current_theme.foreground
theme.fg_urgent = current_theme.background
theme.fg_minimize = current_theme.background

-- menu
theme.menu_submenu_icon = nil
theme.menu_font = current_theme.foreground
theme.menu_height = dpi(24)
theme.menu_width = dpi(200)

-- gap
theme.gap_single_client = false

-- useless
theme.useless_gap = dpi(6)

-- border
theme.border_width = dpi(2)
theme.border_normal = current_theme.background
theme.border_focus = current_theme.color8
theme.border_marked = current_theme.color4

-- fullscreen\
theme.fullscreen_hide_border = true

-- maximized
theme.maximized_honor_padding = true
theme.maximized_hide_border = true

-- systray
theme.systray_icon_spacing = dpi(6)

-- -- hotkeys_popup
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "normal")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "normal", "press")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "focus")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "focus", "press")

theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

theme = theme_assets.recolor_layout(theme, theme.fg_focus)

-- awesome
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.fg_normal)

return theme
