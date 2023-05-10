local config = {}

config.apps = {
    terminal = os.getenv("TERMINAL"),
    editor = os.getenv("TERMINAL") .. " -e " .. os.getenv("EDITOR"),
    browser = "google-chrome-stable --incognito",
}

config.power = {
    shutdown = "systemctl poweroff",
    reboot = "systemctl reboot",
    suspend = "systemctl suspend",
    logout = "loginctl kill-session ''",
    lock = "i3lock --no-unlock-indicator --pointer=default --color '000000'",
}

config.keys = {
    modkey = "Mod4",
    altkey = "Mod1",
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
}

return config
