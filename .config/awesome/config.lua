local config = {}

config.apps = {
    terminal = os.getenv("TERMINAL"),
    editor = os.getenv("TERMINAL") .. " -e " .. os.getenv("EDITOR"),
    run = "run",
    launcher = "launcher",
    powermenu = "powermenu",
}

config.actions = {
    -- Power
    shutdown = "systemctl poweroff",
    reboot = "systemctl reboot",
    sleep = "systemctl suspend",
    hibernate = "systemctl hibernate",
    logout = "loginctl kill-session ''",
    lock = "loginctl lock-session",
    -- screenshot
    screenshot = "scrot --multidisp --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_area = "scrot --select --freeze --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_window = "scrot --focused --border --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    screenshot_delay = "scrot --delay 5 --exec 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'",
    -- other
    randomize_wallpaper = "nitrogen --random --set-zoom-fill --save",
    switch_user = "dm-tool switch-to-greeter",
}

config.keys = {
    super = "Mod4",
    alt = "Mod1",
    shift = "Shift",
    control = "Control",
}

config.tags = {
    name = {
        "General",
        "Code",
        "Chrome",
        "File",
        "Document",
        "Media",
        "Tool",
        "Chat",
        "Game",
        "Setting",
    },
}

return config
