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
    screenshot = "scrot --multidisp --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_area = "scrot --select --freeze --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_window = "scrot --focused --border --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_delay = "scrot --delay 5 --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
}

config.keys = {
    super = "Mod4",
    alt = "Mod1",
    shift = "Shift",
    control = "Control",
}

config.tags = {
    name = {
        " Terminal ",
        " Code ",
        " Chromium ",
        " Files ",
        " Documents ",
        " Media ",
        " Design ",
        " Chat ",
        " Game ",
        " General ",
    },
}

return config
