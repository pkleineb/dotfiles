-- Tokyo-Night theme
-- Copy (or symlink) this file to themes/theme.lua so hyprland.lua picks it up.

-- GTK / icon theme (re-run on every reload, like the old `exec =`)
local function apply_gtk()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyo-Night'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end

hl.on("hyprland.start",  apply_gtk)
hl.on("config.reloaded", apply_gtk)

hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = "rgba(bb8af7cc)",
            inactive_border = "rgba(565f89cc)",
        },
        layout           = "dwindle",
        resize_on_border = true,
    },

    group = {
        col = {
            border_active          = "rgba(bb9af7ff)",
            border_inactive        = "rgba(565f89cc)",
            border_locked_active   = "rgba(bb9af7ff)",
            border_locked_inactive = "rgba(565f89cc)",
        },
    },

    decoration = {
        rounding = 2,

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = true,
        },
    },
})

hl.layer_rule({
    name  = "waybar_background_blur",
    match = { namespace = "waybar" },
    blur  = true,
})
