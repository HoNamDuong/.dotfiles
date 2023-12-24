local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = require("beautiful.xresources").apply_dpi
local filesystem = require("gears.filesystem")
local recolor_image = require("gears.color").recolor_image
local color = require("utils.color")

local xrdb = xresources.get_current_theme()

local themes_path = string.match(filesystem.get_configuration_dir(), "^(/?.-)/*$") .. "/themes/"

local theme = {}

-- palette 
theme.palette = setmetatable({

    background      = xrdb.background,  -- #1a1b26
    foreground      = xrdb.foreground,  -- #c0caf5

    black           = xrdb.color0,      -- #1a1b26
    red             = xrdb.color1,      -- #f7768e
    green           = xrdb.color2,      -- #9ece6a
    yellow          = xrdb.color3,      -- #e0af68
    blue            = xrdb.color4,      -- #7aa2f7
    magenta         = xrdb.color5,      -- #bb9af7
    cyan            = xrdb.color6,      -- #7dcfff
    white           = xrdb.color7,      -- #a9b1d6

    black_bright    = xrdb.color8,      -- #414868
    red_bright      = xrdb.color9,      -- #f7768e
    green_bright    = xrdb.color10,     -- #9ece6a
    yellow_bright   = xrdb.color11,     -- #e0af68
    blue_bright     = xrdb.color12,     -- #7aa2f7
    magenta_bright  = xrdb.color13,     -- #bb9af7
    cyan_bright     = xrdb.color14,     -- #7dcfff
    white_bright    = xrdb.color15,     -- #c0caf5

}, color.palette_metatable)

-- common
theme.common = {

    background      = theme.palette.background,
    foreground      = theme.palette.foreground,

    primary         = theme.palette.blue,
    primary_dark    = theme.palette.blue_70,

    secondary       = theme.palette.black_bright,
    secondary_dark  = theme.palette.black_bright_70,

    low             = theme.palette.green,
    low_dark        = theme.palette.green_40,
    medium          = theme.palette.yellow,
    medium_dark     = theme.palette.yellow_40,
    high            = theme.palette.red,
    high_dark       = theme.palette.red_40,

}

-- icon theme
theme.icon_theme                = "Papirus-Dark"

-- font
theme.font_name                 = "Hack Nerd Font Mono"
theme.font_size                 = 12
theme.font                      = theme.font_name .. " " .. theme.font_size

-- background
theme.bg_normal                 = theme.common.background
theme.bg_focus                  = theme.common.secondary
theme.bg_urgent                 = theme.common.high
theme.bg_minimize               = theme.common.background

-- foreground
theme.fg_normal                 = theme.common.foreground
theme.fg_focus                  = theme.common.foreground
theme.fg_urgent                 = theme.common.background
theme.fg_minimize               = theme.common.foreground

-- border
theme.border_width              = dpi(2)
theme.border_color_normal       = theme.common.secondary
theme.border_color_active       = theme.common.primary
theme.border_color_urgent	    = theme.common.high

-- tasklist
theme.tasklist_bg_normal        = theme.common.secondary
theme.tasklist_bg_focus         = theme.common.primary
theme.tasklist_bg_urgent        = theme.common.high
theme.tasklist_bg_minimize      = theme.common.background

theme.tasklist_fg_normal        = theme.common.foreground
theme.tasklist_fg_focus         = theme.common.background
theme.tasklist_fg_urgent        = theme.common.background
theme.tasklist_fg_minimize      = theme.common.foreground

-- menu
theme.menu_height               = dpi(6) * 4
theme.menu_width                = dpi(6) * 10 * 3
theme.menu_border_width         = theme.border_width
theme.menu_border_color         = theme.common.secondary

-- snap
theme.snap_border_width         = theme.border_width
theme.snap_bg                   = theme.common.primary
theme.snapper_gap               = dpi(0)

-- useless gap
theme.useless_gap               = dpi(6)
theme.gap_single_client         = false

-- systray
theme.systray_icon_spacing      = dpi(6)
theme.bg_systray                = theme.common.secondary_dark

-- hotkeys popup
theme.hotkeys_font              = theme.font
theme.hotkeys_modifiers_fg      = theme.common.primary
theme.hotkeys_description_font  = theme.font
theme.hotkeys_border_width      = theme.border_width
theme.hotkeys_border_color      = theme.common.secondary
theme.hotkeys_group_margin      = dpi(6) * 4

-- maximized
theme.maximized_honor_padding   = true
theme.maximized_hide_border     = true

-- notification
theme.notification_spacing      = dpi(6) * 2

-- wibar
theme.wibar_height              = dpi(6) * 4

-- cursor
theme.enable_spawn_cursor       = false

-- taglist
theme.taglist_disable_icon      = false

-- fullscreen\
theme.fullscreen_hide_border    = true

-- titlebar
theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

-- theme = theme_assets.recolor_titlebar(theme, theme.common.secondary, "normal")
theme = theme_assets.recolor_titlebar(theme, theme.common.foreground, "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.common.medium, "normal", "press")
-- theme = theme_assets.recolor_titlebar(theme, theme.common.primary, "focus")
theme = theme_assets.recolor_titlebar(theme, theme.common.foreground, "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.common.medium, "focus", "press")

-- layout
theme.layout_fairh      = themes_path .. "default/layouts/fairh.png"
theme.layout_fairv      = themes_path .. "default/layouts/fairv.png"
theme.layout_floating   = themes_path .. "default/layouts/floating.png"
theme.layout_magnifier  = themes_path .. "default/layouts/magnifier.png"
theme.layout_max        = themes_path .. "default/layouts/max.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path .. "default/layouts/tileleft.png"
theme.layout_tile       = themes_path .. "default/layouts/tile.png"
theme.layout_tiletop    = themes_path .. "default/layouts/tiletop.png"
theme.layout_spiral     = themes_path .. "default/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "default/layouts/dwindle.png"
theme.layout_cornernw   = themes_path .. "default/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "default/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "default/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "default/layouts/cornerse.png"

-- theme = theme_assets.recolor_layout(theme, theme.common.primary)

-- power
theme.lock_icon         = recolor_image(themes_path .. "default/power/lock.svg",            theme.common.secondary)
theme.logout_icon       = recolor_image(themes_path .. "default/power/logout.svg",          theme.common.secondary)
theme.sleep_icon        = recolor_image(themes_path .. "default/power/sleep.svg",           theme.common.secondary)
theme.restart_icon      = recolor_image(themes_path .. "default/power/restart.svg",         theme.common.secondary)
theme.shutdown_icon     = recolor_image(themes_path .. "default/power/shutdown.svg",        theme.common.high)

-- tag
theme.terminal_icon     = recolor_image(themes_path .. "/default/tag/terminal.svg",         theme.common.foreground)
theme.code_icon         = recolor_image(themes_path .. "/default/tag/code.svg",             theme.common.foreground)
theme.chrome_icon       = recolor_image(themes_path .. "/default/tag/chrome.svg",           theme.common.foreground)
theme.files_icon        = recolor_image(themes_path .. "/default/tag/files.svg",            theme.common.foreground)
theme.document_icon     = recolor_image(themes_path .. "/default/tag/document.svg",         theme.common.foreground)
theme.media_icon        = recolor_image(themes_path .. "/default/tag/media.svg",            theme.common.foreground)
theme.tools_icon        = recolor_image(themes_path .. "/default/tag/tools.svg",            theme.common.foreground)
theme.chat_icon         = recolor_image(themes_path .. "/default/tag/chat.svg",             theme.common.foreground)
theme.game_icon         = recolor_image(themes_path .. "/default/tag/game.svg",             theme.common.foreground)
theme.general_icon      = recolor_image(themes_path .. "/default/tag/general.svg",          theme.common.foreground)

-- player
theme.previous_icon     = recolor_image(themes_path .. "default/player/previous.svg",       theme.common.foreground)
theme.play_icon         = recolor_image(themes_path .. "default/player/play.svg",           theme.common.foreground)
theme.stop_icon         = recolor_image(themes_path .. "default/player/stop.svg",           theme.common.foreground)
theme.pause_icon        = recolor_image(themes_path .. "default/player/pause.svg",          theme.common.foreground)
theme.next_icon         = recolor_image(themes_path .. "default/player/next.svg",           theme.common.foreground)

-- arrow
theme.arrow_down_icon   = recolor_image(themes_path .. "default/other/arrow_down.svg",      theme.common.secondary)
theme.arrow_up_icon     = recolor_image(themes_path .. "default/other/arrow_up.svg",        theme.common.secondary)
theme.arrow_right_icon  = recolor_image(themes_path .. "default/other/arrow_right.svg",     theme.common.secondary)
theme.arrow_left_icon   = recolor_image(themes_path .. "default/other/arrow_left.svg",      theme.common.secondary)

-- other icon
theme.menu_submenu_icon = recolor_image(themes_path .. "default/other/submenu.svg",         theme.common.secondary)
theme.notification_icon = recolor_image(themes_path .. "default/other/notification.svg",    theme.common.secondary)
theme.setting_icon      = recolor_image(themes_path .. "default/other/setting.svg",         theme.common.secondary)
theme.refresh_icon      = recolor_image(themes_path .. "default/other/refresh.svg",         theme.common.secondary)
theme.book_icon         = recolor_image(themes_path .. "default/other/book.svg",            theme.common.secondary)
theme.keyboard_icon     = recolor_image(themes_path .. "default/other/keyboard.svg",        theme.common.secondary)
theme.awesome_icon      = recolor_image(themes_path .. "default/other/awesomewm.svg",       theme.common.primary)
theme.os_icon           = recolor_image(themes_path .. "default/other/archlinux.svg",       theme.common.primary)
theme.dashboard_icon    = recolor_image(themes_path .. "default/other/dashboard.svg",       theme.common.primary)
theme.menu_icon         = recolor_image(themes_path .. "default/other/menu.svg",            theme.common.primary)
theme.bin_icon          = recolor_image(themes_path .. "default/other/bin.svg",             theme.common.high)
theme.image_icon        = recolor_image(themes_path .. "default/other/image.svg",           theme.palette.green)
theme.camera_icon       = recolor_image(themes_path .. "default/other/camera.svg",          theme.palette.blue)
theme.switch_user_icon  = recolor_image(themes_path .. "default/other/switch_user.svg",     theme.palette.yellow)

theme.download_icon     = recolor_image(themes_path .. "default/other/download.svg",        theme.palette.white)
theme.upload_icon       = recolor_image(themes_path .. "default/other/upload.svg",          theme.palette.white)
theme.hard_drive_icon   = recolor_image(themes_path .. "default/other/hard_drive.svg",      theme.palette.blue)
theme.temperature_icon  = recolor_image(themes_path .. "default/other/temperature.svg",     theme.palette.magenta)
theme.gpu_icon          = recolor_image(themes_path .. "default/other/gpu.svg",             theme.palette.green)
theme.memory_icon       = recolor_image(themes_path .. "default/other/memory.svg",          theme.palette.cyan)
theme.cpu_icon          = recolor_image(themes_path .. "default/other/cpu.svg",             theme.palette.magenta)
theme.clock_icon        = recolor_image(themes_path .. "default/other/clock.svg",           theme.palette.green)
theme.volume_icon       = recolor_image(themes_path .. "default/other/volume.svg",          theme.palette.blue)
theme.volume_mute_icon  = recolor_image(themes_path .. "default/other/volume_mute.svg",     theme.common.medium)
theme.mic_icon          = recolor_image(themes_path .. "default/other/mic.svg",             theme.palette.cyan)
theme.mic_off_icon      = recolor_image(themes_path .. "default/other/mic_off.svg",         theme.common.medium)

theme.add_icon          = recolor_image(themes_path .. "default/other/add.svg",             theme.common.secondary)
theme.subtract_icon     = recolor_image(themes_path .. "default/other/subtract.svg",        theme.common.secondary)

-- color icon
theme.package_icon      = themes_path .. "default/other/package.svg"

return theme
