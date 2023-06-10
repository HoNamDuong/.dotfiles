local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = require("beautiful.xresources").apply_dpi
local filesystem = require("gears.filesystem")
local recolor_image = require("gears.color").recolor_image
local color = require("utils.color")

local xrdb = xresources.get_current_theme()

-- local themes_path = filesystem.get_themes_dir()
local themes_path = string.match(filesystem.get_configuration_dir(), "^(/?.-)/*$") .. "/themes/"

local theme = {}

-- color
theme.palette = setmetatable({
    background = xrdb.background,
    foreground = xrdb.foreground,

    black = xrdb.color0, -- #1a1b26
    red = xrdb.color1, -- #f7768e
    green = xrdb.color2, -- #9ece6a
    yellow = xrdb.color3, -- #e0af68
    blue = xrdb.color4, -- #7aa2f7
    magenta = xrdb.color5, -- #bb9af7
    cyan = xrdb.color6, -- #7dcfff
    white = xrdb.color7, -- #a9b1d6

    black_bright = xrdb.color8, -- #414868
    red_bright = xrdb.color9, -- #f7768e
    green_bright = xrdb.color10, -- #9ece6a
    yellow_bright = xrdb.color11, -- #e0af68
    blue_bright = xrdb.color12, -- #7aa2f7
    magenta_bright = xrdb.color13, -- #bb9af7
    cyan_bright = xrdb.color14, -- #7dcfff
    white_bright = xrdb.color15, -- #c0caf5

    primary = xrdb.color4, -- #7aa2f7 
    secondary = xrdb.color8, -- #414868
    urgent = xrdb.color1, -- #f7768e

    low =xrdb.color2, -- #9ece6a 
    medium = xrdb.color3, -- #e0af68,
    high = xrdb.color1, -- #f7768e,
}, color.palette_metatable)

-- icon application
theme.icon_theme = "Papirus-Dark"

-- font
theme.font_name = "Hack Nerd Font Mono"
theme.font_size = 12
theme.font = theme.font_name .. " " .. theme.font_size

-- background
theme.bg_normal = theme.palette.background
theme.bg_focus = theme.palette.secondary
theme.bg_urgent = theme.palette.urgent
theme.bg_minimize = theme.palette.white_bright

-- foreground
theme.fg_normal = theme.palette.foreground
theme.fg_focus = theme.palette.foreground
theme.fg_urgent = theme.palette.background
theme.fg_minimize = theme.palette.foreground

-- tasklist
theme.tasklist_bg_normal = theme.palette.secondary
theme.tasklist_bg_focus = theme.palette.primary
theme.tasklist_bg_urgent = theme.palette.urgent
theme.tasklist_bg_minimize = theme.palette.background

theme.tasklist_fg_normal = theme.palette.foreground
theme.tasklist_fg_focus = theme.palette.background
theme.tasklist_fg_urgent = theme.palette.background
theme.tasklist_fg_minimize = theme.palette.foreground

-- border
theme.border_width = dpi(2)
theme.border_normal = theme.palette.secondary
theme.border_focus = theme.palette.primary
theme.border_marked = theme.palette.yellow

-- menu
theme.menu_submenu_icon = nil
theme.menu_font = theme.palette.foreground
theme.menu_height = dpi(6) * 4
theme.menu_width = dpi(60) * 3
-- theme.menu_border_width = theme.border_width
theme.menu_border_color = theme.palette.secondary

-- snap
theme.snap_bg = theme.palette.primary
theme.snap_border_width = dpi(2)

-- useless gap
theme.useless_gap = dpi(6)
theme.gap_single_client = false

-- fullscreen\
theme.fullscreen_hide_border = true

-- maximized
theme.maximized_honor_padding = true
theme.maximized_hide_border = true

-- systray
theme.systray_icon_spacing = dpi(6)
theme.bg_systray = theme.palette.background

-- notification
theme.notification_spacing = theme.useless_gap * 2
theme.notification_icon = themes_path .. "default/other/notification.svg"

-- hotkeys popup
theme.hotkeys_font = theme.font
theme.hotkeys_modifiers_fg = theme.palette.primary
theme.hotkeys_description_font = theme.font
theme.hotkeys_border_width = dpi(2)
theme.hotkeys_border_color = theme.palette.secondary
theme.hotkeys_group_margin = theme.useless_gap * 4

-- wibar
theme.wibar_height = theme.useless_gap * 4

-- cursor
theme.enable_spawn_cursor = false

-- -- generate taglist squares
-- local taglist_square_size = dpi(28)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
-- theme.taglist_disable_icon = true

-- titlebar
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

theme = theme_assets.recolor_titlebar(theme, theme.palette.secondary, "normal")
theme = theme_assets.recolor_titlebar(theme, theme.palette.foreground, "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.palette.white, "normal", "press")
theme = theme_assets.recolor_titlebar(theme, theme.palette.primary, "focus")
theme = theme_assets.recolor_titlebar(theme, theme.palette.foreground, "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.palette.white, "focus", "press")

-- layout
theme.layout_fairh = themes_path .. "default/layouts/fairh.png"
theme.layout_fairv = themes_path .. "default/layouts/fairv.png"
theme.layout_floating = themes_path .. "default/layouts/floating.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifier.png"
theme.layout_max = themes_path .. "default/layouts/max.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottom.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleft.png"
theme.layout_tile = themes_path .. "default/layouts/tile.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletop.png"
theme.layout_spiral = themes_path .. "default/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindle.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernw.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornerne.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersw.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornerse.png"

-- theme = theme_assets.recolor_layout(theme, theme.palette.primary)

-- power menu
theme.power_lock = recolor_image(themes_path .. "default/power/lock.svg", theme.palette.secondary)
theme.power_logout = recolor_image(themes_path .. "default/power/logout.svg", theme.palette.secondary)
theme.power_sleep = recolor_image(themes_path .. "default/power/sleep.svg", theme.palette.secondary)
theme.power_restart = recolor_image(themes_path .. "default/power/restart.svg", theme.palette.secondary)
theme.power_shutdown = recolor_image(themes_path .. "default/power/shutdown.svg", theme.palette.urgent)

-- tag
theme.tag_terminal  = recolor_image(themes_path .. "/default/tag/terminal.svg", theme.palette.white)
theme.tag_code      = recolor_image(themes_path .. "/default/tag/code.svg",     theme.palette.white)
theme.tag_chrome    = recolor_image(themes_path .. "/default/tag/chrome.svg",   theme.palette.white)
theme.tag_files     = recolor_image(themes_path .. "/default/tag/files.svg",    theme.palette.white)
theme.tag_document  = recolor_image(themes_path .. "/default/tag/document.svg", theme.palette.white)
theme.tag_media     = recolor_image(themes_path .. "/default/tag/media.svg",    theme.palette.white)
theme.tag_edit      = recolor_image(themes_path .. "/default/tag/edit.svg",     theme.palette.white)
theme.tag_chat      = recolor_image(themes_path .. "/default/tag/chat.svg",     theme.palette.white)
theme.tag_game      = recolor_image(themes_path .. "/default/tag/game.svg",     theme.palette.white)
theme.tag_general   = recolor_image(themes_path .. "/default/tag/general.svg",  theme.palette.white)

-- other icon
theme.menu_submenu_icon = recolor_image(themes_path .. "default/other/submenu.svg", theme.palette.secondary)
theme.awesome_icon      = recolor_image(themes_path .. "default/other/awesomewm.svg", theme.palette.primary)
theme.os_icon           = recolor_image(themes_path .. "default/other/archlinux.svg", theme.palette.primary)
theme.bin_icon          = recolor_image(themes_path .. "default/other/bin.svg", theme.palette.urgent)
theme.setting_icon      = recolor_image(themes_path .. "default/other/setting.svg", theme.palette.secondary)
theme.refresh_icon      = recolor_image(themes_path .. "default/other/refresh.svg", theme.palette.secondary)
theme.book_icon         = recolor_image(themes_path .. "default/other/book.svg", theme.palette.secondary)
theme.keyboard_icon     = recolor_image(themes_path .. "default/other/keyboard.svg", theme.palette.secondary)
theme.image_icon        = recolor_image(themes_path .. "default/other/image.svg", theme.palette.green)
theme.camera_icon       = recolor_image(themes_path .. "default/other/camera.svg", theme.palette.blue)
theme.dashboard_icon    = recolor_image(themes_path .. "default/other/dashboard.svg", theme.palette.primary)
theme.menu_icon         = recolor_image(themes_path .. "default/other/menu.svg", theme.palette.primary)

theme.download_icon     = recolor_image(themes_path .. "default/other/download.svg", theme.palette.white)
theme.upload_icon       = recolor_image(themes_path .. "default/other/upload.svg", theme.palette.white)
theme.hard_drive_icon   = recolor_image(themes_path .. "default/other/hard_drive.svg", theme.palette.blue)
theme.temperature_icon  = recolor_image(themes_path .. "default/other/temperature.svg", theme.palette.magenta)
theme.gpu_icon          = recolor_image(themes_path .. "default/other/gpu.svg", theme.palette.green)
theme.memory_icon       = recolor_image(themes_path .. "default/other/memory.svg", theme.palette.cyan)
theme.cpu_icon          = recolor_image(themes_path .. "default/other/cpu.svg", theme.palette.magenta)
theme.volume_icon       = recolor_image(themes_path .. "default/other/volume.svg", theme.palette.blue)
theme.volume_mute_icon  = recolor_image(themes_path .. "default/other/volume_mute.svg", theme.palette.yellow)
theme.mic_icon          = recolor_image(themes_path .. "default/other/mic.svg", theme.palette.cyan)
theme.mic_off_icon      = recolor_image(themes_path .. "default/other/mic_off.svg", theme.palette.yellow)
theme.calendar_icon     = recolor_image(themes_path .. "default/other/calendar.svg", theme.palette.green)

theme.previous_icon = recolor_image(themes_path .. "default/player/previous.svg", theme.palette.white)
theme.play_icon = recolor_image(themes_path .. "default/player/play.svg", theme.palette.white)
theme.stop_icon = recolor_image(themes_path .. "default/player/stop.svg", theme.palette.secondary)
theme.pause_icon = recolor_image(themes_path .. "default/player/pause.svg", theme.palette.white)
theme.next_icon = recolor_image(themes_path .. "default/player/next.svg", theme.palette.white)

theme.arrow_down_icon = recolor_image(themes_path .. "default/other/arrow_down.svg", theme.palette.secondary)
theme.arrow_up_icon = recolor_image(themes_path .. "default/other/arrow_up.svg", theme.palette.secondary)
theme.arrow_right_icon = recolor_image(themes_path .. "default/other/arrow_right.svg", theme.palette.secondary)
theme.arrow_left_icon = recolor_image(themes_path .. "default/other/arrow_left.svg", theme.palette.secondary)

theme.add_icon = recolor_image(themes_path .. "default/other/add.svg", theme.palette.secondary)
theme.subtract_icon = recolor_image(themes_path .. "default/other/subtract.svg", theme.palette.secondary)

-- color icon
theme.package_icon = themes_path .. "default/other/package.svg"

return theme
