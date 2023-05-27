local config = {}

config.apps = {
    terminal = os.getenv("TERMINAL"),
    editor = os.getenv("TERMINAL") .. " -e " .. os.getenv("EDITOR"),
    browser = "google-chrome-stable",
}

config.power = {
    shutdown = "systemctl poweroff",
    restart = "systemctl reboot",
    sleep = "systemctl suspend",
    logout = "loginctl kill-session ''",
    lock = "i3lock --no-unlock-indicator --pointer=default --color '000000'",
}

config.actions = {
    random_wallpaper = "nitrogen --random --set-zoom-fill --save",
}

config.keys = {
    super = "Mod4",
    alt = "Mod1",
}

config.tags = {
    "  Terminal ",
    "  Code ",
    "  Chromium ",
    "  Files ",
    "  Documents ",
    "  Media ",
    "  Design ",
    "  Chat ",
    "  Game ",
    "  General ",

    -- " 1 ",
    -- " 2 ",
    -- " 3 ",
    -- " 4 ",
    -- " 5 ",
    -- " 6 ",
    -- " 7 ",
    -- " 8 ",
    -- " 9 ",
    -- " 0 ",
}

return config
