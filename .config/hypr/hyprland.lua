-- See https://wiki.hypr.land/Configuring/Start/

local home = os.getenv("HOME")

local terminal = "kitty"
local menu = "wofi -c ~/.config/wofi/config -I"

-- Monitors
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({
    output = "desc:Samsung Display Corp. 0x4165",
    mode = "3840x2400@60",
    position = "320x1440",
    scale = 2,
})
hl.monitor({
    output = "desc:Lenovo Group Limited LEN T32h-20 VNA5Z1TL",
    mode = "2560x1440",
    position = "0x0",
    scale = 1,
})
hl.monitor({
    output = "desc:Chimei Innolux Corporation 0x14F5",
    mode = "1920x1080",
    position = "0x0",
    scale = 1,
})
hl.monitor({
    output = "desc:Dell Inc. DELL 4320 50C8M45D0120",
    mode = "1920x1080",
    position = "0x0",
    scale = 1,
})

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd(home .. "/.config/hypr/scripts/wallpaper.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprctl setcursor Qogir-dark 24")
    hl.exec_cmd("wlsunset -S 05:30 -s 20:00")
    hl.exec_cmd("/usr/lib64/polkit-kde-authentication-agent-1")
end)

-- Environment
hl.env("GTK_THEME", "Qogir-Dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Qogir-dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- Nvidia
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("NVD_BACKEND", "direct")

-- Input and appearance
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_model = "",
        kb_rules = "",
        follow_mouse = 2,
        sensitivity = 0.0,
        repeat_rate = 60,
        repeat_delay = 300,
        touchpad = {
            natural_scroll = true,
        },
    },
    general = {
        gaps_in = 2,
        gaps_out = 8,
        border_size = 1,
        col = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = false,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

hl.curve("myBezier", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Window rules
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

local appRules = {
    { class = "org.mozilla.firefox", workspace = "1" },
    { class = "chromium-browser", workspace = "1" },
    { class = "vivaldi-stable", workspace = "1", group = "set" },
    { class = "jetbrains-idea", workspace = "2", group = "set" },
    { class = "kitty", workspace = "3", fullscreen = true },
    { class = "org.mozilla.Thunderbird", workspace = "4 silent" },
    { class = "org.signal.Signal", workspace = "4 silent" },
    { class = "Logseq", workspace = "5 silent" },
    { class = "obsidian", workspace = "5 silent" },
    { class = "Spotify", workspace = "5 silent" },
}

for _, rule in ipairs(appRules) do
    hl.window_rule({
        match = { class = rule.class },
        workspace = rule.workspace,
        group = rule.group,
        fullscreen = rule.fullscreen,
    })
end

hl.window_rule({
    match = { class = "^(jetbrains-.*)$", title = "^(splash)$", float = true },
    tag = "+jetbrains-splash",
})
hl.window_rule({ match = { tag = "jetbrains-splash" }, center = true })
hl.window_rule({ match = { tag = "jetbrains-splash" }, no_focus = true })
hl.window_rule({ match = { tag = "jetbrains-splash" }, border_size = 0 })

hl.window_rule({
    match = { class = "^(jetbrains-.*)", title = "^()$", float = true },
    tag = "+jetbrains",
})
hl.window_rule({ match = { tag = "jetbrains" }, center = true })
hl.window_rule({ match = { tag = "jetbrains" }, stay_focused = true })
hl.window_rule({ match = { tag = "jetbrains" }, border_size = 0 })
hl.window_rule({
    match = { class = "^(jetbrains-.*)", title = "^()$", float = true },
    size = { ">50%", ">50%" },
})
hl.window_rule({
    match = { class = "^(jetbrains-.*)$", title = "^(win.*)$", float = true },
    no_initial_focus = true,
})
hl.window_rule({ match = { class = "^(jetbrains-.*)$" }, no_follow_mouse = true })

hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

-- Keybindings
local mainMod = "SUPER + ALT + SHIFT + CTRL"

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh selection"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Clamshell
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/clamshell.sh toggle"))
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/clamshell.sh close"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/clamshell.sh open"), { locked = true })

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("flatpak run org.mozilla.firefox"))

-- Timetracking submap
hl.bind(mainMod .. " + T", hl.dsp.submap("timetracking"))

hl.define_submap("timetracking", function()
    local function bindActivity(key, activity)
        hl.bind(key, function()
            hl.exec_cmd(home .. "/.bin/timetracking.sh " .. activity)
            hl.dispatch(hl.dsp.submap("reset"))
        end, { repeating = true })
    end

    local commands = {
        C = "collab",
        D = "dev",
        K = "know",
        O = "org",
        Q = "quit",
        R = "rand",
    }

    for key, activity in pairs(commands) do
        bindActivity(key, activity)
    end

    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Focus and groups
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + tab", hl.dsp.group.next())

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + M", hl.dsp.workspace.swap_monitors({
    monitor1 = "current",
    monitor2 = "+1",
}))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
