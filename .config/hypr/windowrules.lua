----------------------
---- WINDOW RULES ----
----------------------

-- See https://wiki.hypr.land/configuring/core/rules/window-rules/
-- Rules are evaluated top to bottom; the last match wins.

-- Build one rule that matches any of the given classes (same anchored
-- regex the old per-class rules used: ^(a|b|c)$).
local function classes(list)
    return "^(" .. table.concat(list, "|") .. ")$"
end

local function opacity(value, list)
    hl.window_rule({ match = { class = classes(list) }, opacity = value })
end

local function float(list)
    hl.window_rule({ match = { class = classes(list) }, float = true })
end

-- Opacity ------------------------------------------------------------------

opacity("0.90 0.90", {
    "firefox",
    "Brave-browser",
    "com.github.rafostar.Clapper",      -- Clapper-Gtk
})

opacity("0.80 0.80", {
    "Steam", "steam", "steamwebhelper",
    "Spotify",
    "Code", "code-url-handler",
    "kitty",
    "org.kde.dolphin",
    "org.kde.ark",
    "nwg-look",
    "qt5ct",
    "com.github.tchx84.Flatseal",       -- Flatseal-Gtk
    "hu.kramo.Cartridges",              -- Cartridges-Gtk
    "com.obsproject.Studio",            -- Obs-Qt
    "gnome-boxes",                      -- Boxes-Gtk
    "discord",                          -- Discord-Electron
    "WebCord",                          -- WebCord-Electron
    "app.drey.Warp",                    -- Warp-Gtk
    "net.davidotek.pupgui2",            -- ProtonUp-Qt
    "yad",                              -- Protontricks-Gtk
    "Signal",                           -- Signal-Gtk
    "io.gitlab.theevilskeleton.Upscaler", -- Upscaler-Gtk
})

opacity("0.80 0.70", {
    "pavucontrol",
    "blueman-manager",
    "nm-applet",
    "nm-connection-editor",
    "org.kde.polkit-kde-authentication-agent-1",
})

-- Floating -----------------------------------------------------------------

float({
    "qt5ct",
    "nwg-look",
    "org.kde.ark",
    "Signal",                           -- Signal-Gtk
    "com.github.rafostar.Clapper",      -- Clapper-Gtk
    "app.drey.Warp",                    -- Warp-Gtk
    "net.davidotek.pupgui2",            -- ProtonUp-Qt
    "yad",                              -- Protontricks-Gtk
    "eog",                              -- Imageviewer-Gtk
    "io.gitlab.theevilskeleton.Upscaler", -- Upscaler-Gtk
    "pavucontrol",
    "blueman-manager",
    "nm-applet",
    "nm-connection-editor",
    "org.kde.polkit-kde-authentication-agent-1",
})

-- tidal-hifi: floating, centered, half the monitor size
hl.window_rule({
    match  = { class = "^(tidal-hifi)$" },
    float  = true,
    center = true,
    size   = "(monitor_w*0.5) (monitor_h*0.5)",
})

-- satty (screenshot annotation)
hl.window_rule({
    match  = { class = "^(com.gabm.satty)$" },
    float  = true,
    center = true,
})
