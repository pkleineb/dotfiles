------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- screenshare
    hl.exec_cmd("xdg-desktop-portal-hyprland") -- initialize XDPH
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH

    -- authclient
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1") -- authentication dialogue for GUI apps

    -- systemapps
    hl.exec_cmd("waybar")                                   -- launch the system panel
    hl.exec_cmd("blueman-applet")                           -- systray app for BT
    hl.exec_cmd("nm-applet --indicator")                    -- systray app for Network/Wifi
    hl.exec_cmd("dunst")                                    -- start notification daemon
    hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- clipboard store text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- clipboard store image data
    hl.exec_cmd("$HOME/.config/hypr/scripts/awwwallpaper.sh")
    hl.exec_cmd("zmk-battery-tray & disown")
    hl.exec_cmd("/usr/lib/pam_kwallet_init")                -- kwallet
    -- hl.exec_cmd("$scrPath/batterynotify.sh")             -- battery notification

    -- easy effects
    -- hl.exec_cmd("easyeffects & disown")

    -- plugins
    -- hl.exec_cmd("hyprpm reload -n")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("STARSHIP_CONFIG", "/home/paul/.config/starship/config.toml") -- this needs to be resolved better
hl.env("ZDOTDIR", "/home/paul/.config/zsh/")                         -- this needs to be resolved better

-- cursor envs
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_PATH", "~/.local/share/icons/")

-- Electron slop
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Japanese
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "de(us),de,us",
        follow_mouse = 1,

        touchpad = {
            natural_scroll      = true,
            disable_while_typing = false,
        },

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",
    },
})

hl.device({
    name        = "logitech-g305-1",
    sensitivity = -0.85,
})

hl.device({
    name        = "logitech-usb-receiver-mouse",
    sensitivity = -0.85,
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


-----------------
---- LAYOUTS ----
-----------------

hl.config({
    dwindle = {
        preserve_split = true, -- you probably want this
    },

    master = {
        new_status = "master",
    },
})


----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        vrr                     = 0,
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    },

    cursor = {
        no_hardware_cursors = true,
    },
})


---------------------------
---- SOURCED MODULES ----
---------------------------

require("animations")
require("keybindings")
require("windowrules")

require("themes.common")  -- shared theme settings
require("themes.theme")   -- theme specific settings
require("themes.colors")  -- wallbash color override

require("monitors")           -- initially empty, to be configured by user and remains static
require("userprefs")          -- initially empty, to be configured by user and remains static
