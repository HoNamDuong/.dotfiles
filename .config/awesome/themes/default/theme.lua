local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local filesystem = require("gears.filesystem")
local recolor_image = require("gears.color").recolor_image

local color = require("utils.color")

local xrdb = xresources.get_current_theme()

local themes_path = string.match(filesystem.get_configuration_dir(), "^(/?.-)/*$") .. "/themes/"

local theme = {}

-- stylua: ignore start
theme.palette = setmetatable({

    background      = xrdb.background or "#1d1f21",
    foreground      = xrdb.foreground or "#c5c8c6",

    black           = xrdb.color0     or "#1d1f21",
    red             = xrdb.color1     or "#cc6666",
    green           = xrdb.color2     or "#b5bd68",
    yellow          = xrdb.color3     or "#f0c674",
    blue            = xrdb.color4     or "#81a2be",
    magenta         = xrdb.color5     or "#b294bb",
    cyan            = xrdb.color6     or "#8abeb7",
    white           = xrdb.color7     or "#c5c8c6",

    black_bright    = xrdb.color8     or "#373B41",
    red_bright      = xrdb.color9     or "#d54e53",
    green_bright    = xrdb.color10    or "#b9ca4a",
    yellow_bright   = xrdb.color11    or "#e7c547",
    blue_bright     = xrdb.color12    or "#7aa6da",
    magenta_bright  = xrdb.color13    or "#c397d8",
    cyan_bright     = xrdb.color14    or "#70c0b1",
    white_bright    = xrdb.color15    or "#eaeaea",

}, color.palette_metatable)

theme.colors = {

    background      = theme.palette.background,
    foreground      = theme.palette.foreground,

    primary         = theme.palette.blue,
    primary_dull    = theme.palette.blue_60,
    primary_dark    = theme.palette.blue_30,

    secondary       = theme.palette.black_bright,
    secondary_dull  = theme.palette.black_bright_80,
    secondary_dark  = theme.palette.black_bright_60,

    low             = theme.palette.green,
    low_dull        = theme.palette.green_60,
    low_dark        = theme.palette.green_30,
    medium          = theme.palette.yellow,
    medium_dull     = theme.palette.yellow_60,
    medium_dark     = theme.palette.yellow_30,
    high            = theme.palette.red,
    high_dull       = theme.palette.red_60,
    high_dark       = theme.palette.red_30,

}

-- icon theme
theme.icon_theme                = "Papirus-Dark"

-- font
theme.font_name                 = "RobotoMono Nerd Font"
theme.font_size                 = 14
theme.font                      = theme.font_name .. " " .. theme.font_size

-- background
theme.bg_normal                 = theme.colors.background
theme.bg_focus                  = theme.colors.secondary
theme.bg_urgent                 = theme.colors.high

-- foreground
theme.fg_normal                 = theme.colors.foreground
theme.fg_focus                  = theme.colors.foreground
theme.fg_urgent                 = theme.colors.background

-- border
theme.border_width              = dpi(2)
theme.border_color_normal       = theme.colors.secondary
theme.border_color_active       = theme.colors.primary
theme.border_color_urgent	    = theme.colors.high

-- tasklist
theme.tasklist_bg_normal        = theme.colors.secondary
theme.tasklist_bg_focus         = theme.colors.primary
theme.tasklist_bg_urgent        = theme.colors.high
theme.tasklist_bg_minimize      = theme.colors.background

theme.tasklist_fg_normal        = theme.colors.foreground
theme.tasklist_fg_focus         = theme.colors.background
theme.tasklist_fg_urgent        = theme.colors.background
theme.tasklist_fg_minimize      = theme.colors.foreground

-- menu
theme.menu_width                = dpi(6) * 10 * 4
theme.menu_height               = dpi(6) * 4
theme.menu_border_width         = theme.border_width
theme.menu_border_color         = theme.colors.secondary

-- snap
theme.snap_bg                   = theme.colors.primary
theme.snap_shape                = gears.shape.rectangle
theme.snapper_gap               = dpi(0)

-- useless gap
theme.useless_gap               = dpi(6)
theme.gap_single_client         = false

-- systray
theme.systray_icon_spacing      = dpi(6)
theme.bg_systray                = theme.colors.background

-- hotkeys popup
theme.hotkeys_font              = theme.font
theme.hotkeys_modifiers_fg      = theme.colors.primary
theme.hotkeys_description_font  = theme.font
theme.hotkeys_border_width      = theme.border_width
theme.hotkeys_border_color      = theme.colors.secondary
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
theme = theme_assets.recolor_titlebar(theme, theme.colors.foreground, "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.colors.medium, "normal", "press")
-- theme = theme_assets.recolor_titlebar(theme, theme.common.primary, "focus")
theme = theme_assets.recolor_titlebar(theme, theme.colors.foreground, "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.colors.medium, "focus", "press")

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

theme.layout_mstab      = themes_path .. "default/layouts/mstab.png"
theme.layout_deck       = themes_path .. "default/layouts/deck.png"
theme.layout_equalarea  = themes_path .. "default/layouts/equalarea.png"
theme.layout_horizontal = themes_path .. "default/layouts/horizontal.png"
theme.layout_vertical   = themes_path .. "default/layouts/vertical.png"
theme.layout_centered   = themes_path .. "default/layouts/centered.png"

-- theme = theme_assets.recolor_layout(theme, theme.common.primary)

-- tag
theme.general_icon      = recolor_image(themes_path .. "/default/tag/general.svg",          theme.colors.foreground)
theme.code_icon         = recolor_image(themes_path .. "/default/tag/code.svg",             theme.colors.foreground)
theme.chrome_icon       = recolor_image(themes_path .. "/default/tag/chrome.svg",           theme.colors.foreground)
theme.file_icon         = recolor_image(themes_path .. "/default/tag/file.svg",             theme.colors.foreground)
theme.document_icon     = recolor_image(themes_path .. "/default/tag/document.svg",         theme.colors.foreground)
theme.media_icon        = recolor_image(themes_path .. "/default/tag/media.svg",            theme.colors.foreground)
theme.tool_icon         = recolor_image(themes_path .. "/default/tag/tool.svg",             theme.colors.foreground)
theme.chat_icon         = recolor_image(themes_path .. "/default/tag/chat.svg",             theme.colors.foreground)
theme.game_icon         = recolor_image(themes_path .. "/default/tag/game.svg",             theme.colors.foreground)
theme.setting_icon      = recolor_image(themes_path .. "/default/tag/setting.svg",          theme.colors.foreground)

-- player
theme.play_icon         = recolor_image(themes_path .. "default/player/play.svg",           theme.colors.foreground)
theme.pause_icon        = recolor_image(themes_path .. "default/player/pause.svg",          theme.colors.foreground)
theme.stop_icon         = recolor_image(themes_path .. "default/player/stop.svg",           theme.colors.foreground)
theme.next_icon         = recolor_image(themes_path .. "default/player/next.svg",           theme.colors.foreground)
theme.previous_icon     = recolor_image(themes_path .. "default/player/previous.svg",       theme.colors.foreground)

-- arrow
theme.arrow_down_icon   = recolor_image(themes_path .. "default/other/arrow_down.svg",      theme.colors.foreground)
theme.arrow_up_icon     = recolor_image(themes_path .. "default/other/arrow_up.svg",        theme.colors.foreground)
theme.arrow_right_icon  = recolor_image(themes_path .. "default/other/arrow_right.svg",     theme.colors.foreground)
theme.arrow_left_icon   = recolor_image(themes_path .. "default/other/arrow_left.svg",      theme.colors.foreground)

-- power
theme.hibernate_icon    = recolor_image(themes_path .. "default/power/hibernate.svg",       theme.palette.cyan)
theme.lock_icon         = recolor_image(themes_path .. "default/power/lock.svg",            theme.palette.green)
theme.logout_icon       = recolor_image(themes_path .. "default/power/logout.svg",          theme.palette.blue)
theme.reboot_icon       = recolor_image(themes_path .. "default/power/reboot.svg",          theme.palette.yellow)
theme.shutdown_icon     = recolor_image(themes_path .. "default/power/shutdown.svg",        theme.palette.red)
theme.sleep_icon        = recolor_image(themes_path .. "default/power/sleep.svg",           theme.palette.magenta)

-- status
theme.download_icon     = recolor_image(themes_path .. "default/other/download.svg",        theme.palette.white)
theme.upload_icon       = recolor_image(themes_path .. "default/other/upload.svg",          theme.palette.white)
theme.hard_drive_icon   = recolor_image(themes_path .. "default/other/hard_drive.svg",      theme.palette.blue)
theme.temperature_icon  = recolor_image(themes_path .. "default/other/temperature.svg",     theme.palette.magenta)
theme.gpu_icon          = recolor_image(themes_path .. "default/other/gpu.svg",             theme.palette.green)
theme.memory_icon       = recolor_image(themes_path .. "default/other/memory.svg",          theme.palette.cyan)
theme.cpu_icon          = recolor_image(themes_path .. "default/other/cpu.svg",             theme.palette.magenta)
theme.clock_icon        = recolor_image(themes_path .. "default/other/clock.svg",           theme.palette.green)
theme.volume_icon       = recolor_image(themes_path .. "default/other/volume.svg",          theme.palette.blue)
theme.volume_mute_icon  = recolor_image(themes_path .. "default/other/volume_mute.svg",     theme.palette.yellow)
theme.mic_icon          = recolor_image(themes_path .. "default/other/mic.svg",             theme.palette.cyan)
theme.mic_off_icon      = recolor_image(themes_path .. "default/other/mic_off.svg",         theme.palette.yellow)

-- other icon
theme.menu_submenu_icon = recolor_image(themes_path .. "default/other/submenu.svg",         theme.colors.foreground)
theme.notification_icon = recolor_image(themes_path .. "default/other/notification.svg",    theme.colors.foreground)
theme.edit_icon         = recolor_image(themes_path .. "default/other/edit.svg",            theme.colors.foreground)
theme.refresh_icon      = recolor_image(themes_path .. "default/other/refresh.svg",         theme.colors.foreground)
theme.book_icon         = recolor_image(themes_path .. "default/other/book.svg",            theme.colors.foreground)
theme.keyboard_icon     = recolor_image(themes_path .. "default/other/keyboard.svg",        theme.colors.foreground)
theme.add_icon          = recolor_image(themes_path .. "default/other/add.svg",             theme.colors.foreground)
theme.subtract_icon     = recolor_image(themes_path .. "default/other/subtract.svg",        theme.colors.foreground)
theme.awesome_icon      = recolor_image(themes_path .. "default/other/awesomewm.svg",       theme.colors.primary)
theme.dashboard_icon    = recolor_image(themes_path .. "default/other/dashboard.svg",       theme.colors.primary)
theme.menu_icon         = recolor_image(themes_path .. "default/other/menu.svg",            theme.colors.primary)
theme.image_icon        = recolor_image(themes_path .. "default/other/image.svg",           theme.palette.green)
theme.camera_icon       = recolor_image(themes_path .. "default/other/camera.svg",          theme.palette.blue)
theme.switch_user_icon  = recolor_image(themes_path .. "default/other/switch_user.svg",     theme.palette.yellow)

-- color icon
theme.package_icon      = themes_path .. "default/other/package.svg"

-- stylua: ignore end
return theme
